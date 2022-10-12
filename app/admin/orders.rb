ActiveAdmin.register Order do
  permit_params :user_id, :coupon_id, :total_price, :status, :last_action

  index do
    selectable_column

    column :user
    column :coupon
    column :total_price
    column :status
    column :last_action

    actions
  end

  show do
    attributes_table do
      row :user
      row :coupon
      row :total_price
      row :status
      row :delivery_id
      row :last_action
    end
  end

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :coupon_id
      f.input :total_price
      f.input :status
      f.input :last_action
      f.input :delivery_id
      f.input :books
    end

    f.actions
  end
end
