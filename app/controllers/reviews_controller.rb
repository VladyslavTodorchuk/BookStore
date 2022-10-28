class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = current_user.reviews.new(review_params)

    return redirect_to book_path(@review.book), notice: I18n.t('reviews.success') if @review.save

    redirect_to book_path(@review.book), alert: @review.errors.full_messages.join(', ')
  end

  private

  def review_params
    params.permit(:title, :body, :book_id, :rating)
  end
end
