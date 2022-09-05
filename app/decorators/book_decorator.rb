class BookDecorator < Draper::Decorator
  decorates_association :authors

  delegate_all

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def categories_names
    categories.map(&:name).join(', ')
  end
end
