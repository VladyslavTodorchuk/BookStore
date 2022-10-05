require_relative '../services/checkout_service'
class CheckoutsController < ApplicationController
  def new; end

  def create
    user = User.new(email: params[:user][:email], password: Devise.friendly_token.first(Devise.password_length.first))
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

    coupon = Coupon.find_by(code: params[:code])
    coupon&.update(order_id: @order.id)

    step = params[:step]

    if step.nil?
      render 'checkouts/address'
    else
      page = CheckoutService.page_step(step.to_sym)
      render page
    end
  end
end
