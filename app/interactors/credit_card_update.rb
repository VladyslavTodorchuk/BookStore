class CreditCardUpdate
  include Interactor

  def call
    params = context.permitted_params
    credit_card = context.credit_card

    return if params[:credit_card].nil?

    return if credit_card.nil?

    return if credit_card.update(params[:credit_card])

    context.fail!
  end
end
