ActiveAdmin.register Book do
  permit_params :title, :description, :price, :dimensions, :year_of_publication, :materials, :quantity,
                category_ids: [], author_ids: []

end
