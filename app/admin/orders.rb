ActiveAdmin.register Order do
  permit_params :user_id, :coupon_id, :address_id, :total_price, :status, :last_action

  index do
    selectable_column

    column :user
    column :coupon
    column :total_price
    column :status
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :user
      row :coupon
      row :total_price
      row :status
      row :delivery_id
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :coupon_id
      f.input :total_price
      f.input :status, as: :select, collection: [:confirmed, :delivered, :canceled, 'in delivery']
      f.input :delivery_id
      f.input :books
    end

    f.actions
  end
end
