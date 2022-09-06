class BookDecorator < Draper::Decorator
  decorates_association :authors
  decorates_association :categories

  def self.collection_decorator_class
    PaginatingDecorator
  end

  delegate_all

  def authors_names
    authors.map(&:full_name)
  end

  def categories_names
    categories.map(&:name)
  end
end
