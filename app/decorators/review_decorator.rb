class ReviewDecorator < Draper::Decorator
  delegate_all

  def date_time
    created_at.strftime('%m/%d/%Y')
  end
end