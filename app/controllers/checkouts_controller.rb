class CheckoutsController < ApplicationController
  def new; end

  def create
    user = User.new(email: params[:user][:email], password: Devise.friendly_token.first(Devise.password_length.first))
    user.skip_confirmation!

    if user.save
      sign_in(:user, user)
      user.send_reset_password_instructions
      redirect_to order_path(session[:order_id])
    else
      redirect_to new_checkout_path, alert: I18n.t('checkout.error_message')
    end
  end
end
