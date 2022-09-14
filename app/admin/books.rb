ActiveAdmin.register Book do
  permit_params :title, :description, :price_cents, :dimensions, :year_of_publication, :materials, :quantity,
                author_ids: [], category_ids: [], images: []

  decorate_with BookDecorator

  filter :authors, collection: Author.all
  filter :categories
  filter :title
  filter :year_of_publication
  index do
    selectable_column

    column :title
    column :year_of_publication
    column :materials
    column :dimensions
    column :price
    column :quantity
    column :authors_names
    column :categories_names

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
      row :price_cents, &:price
      row :created_at
      row :updated_at
    end

    panel :images do
      table do
        book.images.each do |image|
          span image_tag image.variant(resize_to_limit: [100, 100])
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :year_of_publication
      f.input :price_cents
      f.input :materials
      f.input :dimensions
      f.input :quantity

      f.input :categories, as: :select, collection: Category.all
      f.input :authors, as: :select, collection: Author.all
      f.input :images, as: :file, input_html: { multiple: true }
    end

    panel :images do
      f.object.images.each do |image|
        span image_tag image.variant(resize_to_limit: [100, 100])
        span link_to('Delete', delete_image_admin_book_path(image.id), method: :delete,
                                                                       data: { confirm: "Delete #{image.filename}?" })
      end
    end

    f.actions
  end

  member_action :delete_image, method: :delete do
    ActiveStorage::Attachment.find(params[:id]).purge_later
    redirect_back(fallback_location: edit_admin_book_path)
  end
end
