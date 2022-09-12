class ShippingUpdate
  include Interactor

  def call
    params = context.permitted_params
    user = context.current_user

    return if params[:shipping].nil?

    return if user.shipping.update(params[:shipping])

    context.fail!
  end
end
