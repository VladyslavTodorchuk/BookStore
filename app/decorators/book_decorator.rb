class BookDecorator < Draper::Decorator
  decorates_association :authors

  def self.collection_decorator_class
    PaginatingDecorator
  end

  delegate_all

  def authors_names
    authors.pluck(:full_name).join(', ')
  end

  def categories_names
    categories.pluck(:name).join(', ')
  end
end
