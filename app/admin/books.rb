ActiveAdmin.register Book do
  permit_params :title, :description, :price_cents, :dimensions, :year_of_publication, :materials, :quantity,
                category_ids: [], author_ids: []

  decorate_with BookDecorator

  filter :authors, collection: AuthorDecorator.decorate_collection(Author.all)
  filter :categories
  filter :title
  filter :year_of_publication

  index do
    selectable_column

    column :title
    column :year_of_publication
    column :materials
    column :dimensions
    column :price_cents, &:price
    column :quantity
    column :authors, &:authors_names
    column :categories, &:categories_names

    actions
  end

  show do
    attributes_table do
      row :authors, &:authors_names
      row :categories, &:categories_names
      row :year_of_publication
      row :description
      row :materials
      row :dimensions
      row :price, &:price
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :year_of_publication
      f.input :price_cents
      f.input :materials
      f.input :dimensions
      f.input :quantity
      f.input :description, as: :text

      f.input :categories, as: :select, collection: Category.all
      f.input :authors, as: :select, collection: AuthorDecorator.decorate_collection(Author.all)
    end

    f.actions
  end
end
