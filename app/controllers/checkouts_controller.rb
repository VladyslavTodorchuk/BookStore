require_relative '../services/checkout_service'

class CheckoutsController < ApplicationController
  before_action :authenticate_user!, :allow_step, only: %i[show update]
  before_action :all_fields_are_required, only: %i[update]

  def create
    user = User.new(email: permitted_params[:user][:email],
                    password: Devise.friendly_token.first(Devise.password_length.first))
    user.skip_confirmation!
    order = Order.find(session[:order_id])

    if user.save
      sign_in(:user, user)
      user.send_reset_password_instructions
      order.update(user_id: user.id)

      redirect_to checkout_path(step: :address)
    else
      redirect_to new_checkout_path, alert: I18n.t('checkout.error_message')
    end
  end

  def show
    @order = Order.find(session[:order_id]).decorate

    @user_billing = Billing.find_or_create_by(user_id: current_user.id)
    @user_shipping = Shipping.find_or_create_by(user_id: current_user.id)
    @credit_card = CreditCard.find_or_create_by(user_id: current_user.id)

    step = permitted_params[:step]

    case step
    when 'initialize' then render 'checkouts/new'
    when 'delivery' then render 'checkouts/delivery'
    when 'address' then render 'checkouts/address'
    when 'payment' then render 'checkouts/payment'
    when 'confirm' then render 'checkouts/confirm'
    when 'complete' then render 'checkouts/complete'
    else
      render 'checkouts/address'
    end
  end

  def update
    @order = Order.find(session[:order_id]).decorate
    @user_billing = Billing.find_or_create_by(user_id: current_user.id)
    @user_shipping = Shipping.find_or_create_by(user_id: current_user.id)
    @credit_card = CreditCard.find_or_create_by(user_id: current_user.id)

    update_case
  end

  private

  def all_fields_are_required
    checkout_service = CheckoutService.new

    redirect_to checkout_path(step: permitted_params[:step]),
                alert: t('orders.messages.error.require_fields') unless checkout_service.check_fields(permitted_params)
  end

  def allow_step
    order = Order.find(session[:order_id])

    if order.books.empty?
      redirect_to books_path
    elsif %w[confirm complete].include?(permitted_params[:step]) && (order.address.nil? || order.delivery.nil?)
      redirect_to checkout_path(step: :address)
    end
  end

  def update_case
    checkout_service = CheckoutUpdateService.new(CheckoutService.new)

    case permitted_params[:step]
    when 'billing'
      redirect_to checkout_path(step: :address), checkout_service.update_billing(permitted_params, @user_billing)
    when 'shipping'
      redirect_to checkout_path(step: :address), checkout_service.update_shipping(permitted_params, @user_shipping)
    when 'payment'
      result = checkout_service.update_payment(permitted_params, @credit_card)
      redirect_to checkout_path(step: result[:step]), result[:message]
    when 'complete'
      result = checkout_service.update_complete(@order)
      return redirect_to checkout_path(ste: result[:step]), result[:message] if result[:step]

      redirect_to root_path, result[:message] unless result[:step]
    end
  end

  def permitted_params
    params.permit(
      :step, :code,
      user: %i[password current_password password_confirmation email],
      billing: %i[first_name last_name address city zip country phone],
      shipping: %i[first_name last_name address city zip country phone],
      credit_card: %i[name code cvv expiration_date]
    )
  end
end
