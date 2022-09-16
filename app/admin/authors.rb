ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  filter :books, collection: BookDecorator.decorate_collection(Book.all)
  filter :first_name
  filter :last_name

  index do
    selectable_column

    column :first_name
    column :last_name

    actions
  end
end
