ActiveAdmin.register Category do
  permit_params :name, book_ids: []
end
