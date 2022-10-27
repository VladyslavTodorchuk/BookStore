ActiveAdmin.register Category do
  permit_params :name, book_ids: []

  filter :books, collection: Book.all
  filter :name

  index do
    selectable_column

    column :name

    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end
end
