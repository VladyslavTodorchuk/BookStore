class CreditCardUpdate
  include Interactor

  def call
    params = context.permitted_params
    user = context.current_user

    return if params[:credit_card].nil?

    return if user.nil?

    return if user.credit_card.update(params[:credit_card])

    context.fail!
  end
end
