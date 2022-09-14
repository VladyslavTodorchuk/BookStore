ActiveAdmin.register Author do
  permit_params :first_name, :last_name, book_ids: []

  index do
    selectable_column

    column :first_name
    column :last_name
    column :books, :title

    actions
  end
end
