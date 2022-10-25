ActiveAdmin.register Review do
  permit_params :user_id, :book_id, :title, :rating, :body, :verified

  index do
    selectable_column

    column :user_id
    column :book_id
    column :rating
    column :verified

    actions
  end

  show do
    attributes_table do
      row :user_id
      row :book_id
      row :rating
      row :verified
      row :title
      row :body
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :verified
    end

    f.actions
  end
end
