class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)

    return redirect_to book_path(@review.book), notice: I18n.t('reviews.success') if @review.save

    redirect_to book_path(@review.book), alert: @review.errors.full_messages.join(', ')
  end

  private

  def review_params
    params.permit(:title, :body, :book_id, :user_id, :rating, :verified)
  end
end
