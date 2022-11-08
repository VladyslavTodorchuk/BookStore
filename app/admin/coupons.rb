ActiveAdmin.register Coupon do
  permit_params :code, :is_active, :active_till_date, :discount, :order_id

  index do
    selectable_column

    column :code
    column :is_active
    column :active_till_date
    column :discount

    actions
  end

  show do
    attributes_table do
      row :code
      row :is_active
      row :active_till_date
      row :discount
      row :order
    end
  end

  form do |f|
    f.inputs do
      f.input :code
      f.input :is_active
      f.input :active_till_date
      f.input :discount
      f.input :order
    end

    f.actions
  end
end
