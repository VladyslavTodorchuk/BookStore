class UserUpdate
  include Interactor

  def call
    params = context.permitted_params
    user = context.current_user

    return BillingUpdate.call(permitted_params: params, current_user: user) unless params[:billing].nil?

    return ShippingUpdate.call(permitted_params: params, current_user: user) unless params[:shipping].nil?

    return if params[:user].nil?

    return user.update(email: params[:email]) if params[:email]

    return user.update(password: params[:password]) if params[:password]

    context.fail!
  end
end
