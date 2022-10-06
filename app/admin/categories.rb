ActiveAdmin.register Category do
  permit_params :name, book_ids: []

  filter :books, collection: Book.all
  filter :name
end
