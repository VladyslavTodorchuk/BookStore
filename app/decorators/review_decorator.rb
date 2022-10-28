class ReviewDecorator < Draper::Decorator
  delegate_all

  def posted_at
    created_at.strftime(Constants::REVIEW_DATE_MASK)
  end
end
