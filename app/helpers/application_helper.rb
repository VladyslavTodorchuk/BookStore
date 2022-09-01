module ApplicationHelper
  include Pagy::Frontend

  SORT_METHODS = ['created_at', 'created_at DESC', 'price DESC', 'most_popular', 'price', 'title', 'title DESC'].freeze
  PAGINATION_PER_PAGE = 12

  DESCRIPTION_LENGTH = 25
end
