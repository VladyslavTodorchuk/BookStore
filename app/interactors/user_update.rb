class UserUpdate
  include Interactor

  def call
    params = context.permitted_params
    user = context.current_user

    billing_and_shipping_update(params, user)

    return if params[:user].nil?

    return if !params[:user][:email].nil? && user.update(email: params[:user][:email])

    return if !params[:user][:password].nil? &&
              user.reset_password(params[:user][:password], params[:user][:password_confirmation])

    context.fail!
  end

  def billing_and_shipping_update(params, user)
    return if !params[:billing].nil? && BillingUpdate.call(permitted_params: params, current_user: user)

    !params[:shipping].nil? && ShippingUpdate.call(permitted_params: params, current_user: user)
  end
end
