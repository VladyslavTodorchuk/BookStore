class BookDecorator < Draper::Decorator
  decorates_association :authors
  decorates_association :categories

  delegate_all

  def authors_names
    authors.map(&:full_name)
  end

  def categories_names
    categories.map(&:name)
  end
end
