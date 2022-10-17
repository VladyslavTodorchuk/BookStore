class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user_billing = Billing.find_or_create_by(user_id: current_user.id)
    @user_shipping = Shipping.find_or_create_by(user_id: current_user.id)
  end

  def update
    update_user = UserUpdate.call(permitted_params: permitted_params, current_user: current_user)

    redirect_to edit_user_path, notice: I18n.t('settings.message.update') if updated? update_user

    redirect_to edit_user_path, notice: I18n.t('settings.error.error') unless updated? update_user
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: I18n.t('devise.registrations.destroyed')
  end

  private

  def updated?(update_user)
    return true if update_user.success?

    false
  end

  def permitted_params
    params.permit(
      user: %i[password current_password password_confirmation email],
      billing: %i[first_name last_name address city zip country phone],
      shipping: %i[first_name last_name address city zip country phone]
    )
  end
end
