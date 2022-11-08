class UserDecorator < Draper::Decorator
  delegate_all

  def username
    return name if name.present?

    email.split('@').first.capitalize
  end
end
