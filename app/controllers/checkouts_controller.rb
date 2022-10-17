require_relative '../services/checkout_service'

class CheckoutsController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]
  def new; end

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
    when 'address' then update_address(permitted_params)
    when 'payment' then update_payment(permitted_params)
    when 'confirm' then update_confirm
    end
  end

  private

  def permitted_params
    params.permit(
      :step, :code,
      user: %i[password current_password password_confirmation email],
      billing: %i[first_name last_name address city zip country phone],
      shipping: %i[first_name last_name address city zip country phone],
      credit_card: %i[name code cvv expiration_date]
    )
  end

  def update_address(permitted_params)
    if permitted_params[:shipping].nil?
      update_billing(permitted_params[:billing])
    else
      update_shipping(permitted_params[:shipping])
    end
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

  def update_payment(permitted_params)
    if @credit_card.update(permitted_params[:credit_card])
      redirect_to checkout_path(step: :confirm)
    else
      redirect_to checkout_path(step: :payment), alert: CheckoutService.to_errors(@credit_card.errors.messages)
    end
  end

  def update_confirm
    @order.coupon&.update(is_active: false)

    if @order.update(status: :created, total_price: count_total_price)
      redirect_to root_path, notice: 'Order was created!'
    else
      redirect_to checkout_path(step: :confirm), alert: 'Something went wrong'
    end
  end

  def count_total_price
    product = OrderBook.where(order_id: @order.id)

    total_price = product.map do |order|
      order.book.price_cents * order.quantity
    end.sum

    total_price *= @order.coupon.discount unless @order.coupon.nil?

    total_price + @order.delivery.price_cents
  end
end
