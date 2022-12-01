class BillingUpdate
  include Interactor

  def call
    params = context.permitted_params
    user = context.current_user

    return if params[:billing].nil?

    return if user.billing.update(params[:billing])

    context.fail!
  end
end
