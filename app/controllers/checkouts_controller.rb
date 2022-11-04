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

    case permitted_params[:step]
    when 'billing' then update_billing(permitted_params[:billing])
    when 'shipping' then update_shipping(permitted_params[:shipping])
    when 'payment' then update_payment(permitted_params)
    when 'complete' then update_complete
    end
  end

  private
  s
  def update_address(permitted_params)
    update_billing(permitted_params[:billing]) unless permitted_params[:billing].nil?

    update_shipping(permitted_params[:shipping]) unless permitted_params[:shipping].nil?
  end

  def update_shipping(params)
    if @user_shipping.update(params)
      redirect_to checkout_path(step: :address), notice: 'Shipping was updated'
    else
      redirect_to checkout_path(step: :address), alert: CheckoutService.to_errors(@user_shipping.errors.messages)
    end
  end

  def update_billing(params)
    if @user_billing.update(params)
      redirect_to checkout_path(step: :address), notice: 'Billing was updated'
    else
      redirect_to checkout_path(step: :address), alert: CheckoutService.to_errors(@user_billing.errors.messages)
    end
  end

  def update_payment(update_params)
    if @credit_card.update(update_params[:credit_card])
      redirect_to checkout_path(step: :confirm), notice: 'Credit Card was updated'
    else
      redirect_to checkout_path(step: :payment), alert: CheckoutService.to_errors(@credit_card.errors.messages)
    end
  end

  def update_complete
    @order.coupon&.update(is_active: false)

    if @order.update(status: :created, total_price: CheckoutService.count_total_price(@order))
      CheckoutService.quantity_update(@order.id)

      redirect_to root_path, notice: t('orders.messages.success.order')
    else
      redirect_to checkout_path(step: :confirm), alert: t('orders.messages.error.something_went_wrong')
    end
  end

  def all_fields_are_required
    redirect_to checkout_path(step: permitted_params[:step]),
                alert: t('orders.messages.error.require_fields') unless CheckoutService.check_fields(permitted_params)
  end

  def allow_step
    order = Order.find(session[:order_id])

    if order.books.empty?
      redirect_to books_path
    elsif %w[confirm complete].include?(permitted_params[:step]) && (order.address.nil? || order.delivery.nil?)
      redirect_to checkout_path(step: :address)
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
