class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user_billing = Billing.find_or_initialize_by(user_id: params[:id])
    @user_shipping = Shipping.find_or_initialize_by(user_id: params[:id])
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: I18n.t('devise.registrations.destroyed')
  end
end
