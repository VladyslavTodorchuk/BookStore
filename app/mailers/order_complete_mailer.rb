class OrderCompleteMailer < ApplicationMailer
  def order_confirmation
    @username = params[:user].decorate.username
    mail(to: params[:user].email, subject: I18n.t('orders.mail.complete'))
  end
end
