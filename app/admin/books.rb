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
    h1 book.title

    attributes_table do
      row :authors, &:authors_names
      row :categories, &:categories_names
      row :year_of_publication
      row :description
      row :materials
      row :dimensions
      row :price_cents, &:price
      row :created_at
      row :updated_at
    end

    active_admin_comments
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

      f.input :categories, as: :check_boxes
      f.input :authors, as: :check_boxes, collection: AuthorDecorator.decorate_collection(Author.all)
    end

    f.actions
  end
end
