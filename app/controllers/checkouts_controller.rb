require_relative '../services/checkout_service'

class CheckoutsController < ApplicationController
  before_action :authenticate_user!, only: %i[show update]
  def new; end

  def create
    user = User.new(email: permitted_params[:user][:email],
                    password: Devise.friendly_token.first(Devise.password_length.first))
    user.skip_confirmation!

    if user.save
      sign_in(:user, user)
      user.send_reset_password_instructions
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

    coupon = Coupon.find_by(code: permitted_params[:code])
    coupon&.update(order_id: @order.id)

    step = permitted_params[:step]

    if step.nil?
      render 'checkouts/address'
    else
      render CheckoutService.page_step(step.to_sym)
    end
  end

  def update
    next_step = { address: :delivery, delivery: :payment, payment: :confirm, confirm: :complete }
    step = params[:step]

    redirect_to checkout_path if step.nil?

    result = CheckoutService.update_step(step.to_sym,
                                         { permitted_params: permitted_params,
                                           user: current_user })

    if result.success?
      redirect_to checkout_path(step: next_step[step.to_sym])
    else
      redirect_to checkout_path(step: step), notice: 'Something went wrong!'
    end
  end

  private

  def permitted_params
    params.permit(
      :step,
      user: %i[password current_password password_confirmation email],
      billing: %i[first_name last_name address city zip country phone],
      shipping: %i[first_name last_name address city zip country phone],
      credit_card: %i[name code cvv expiration_date]
    )
  end
end
