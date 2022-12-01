ActiveAdmin.register Delivery do
  permit_params :price_cents, :delivery_method, :delivery_day

  decorate_with DeliveryDecorator

  index do
    selectable_column

    column :price_cents, &:price
    column :delivery_method
    column :delivery_day

    actions
  end

  show do
    attributes_table do
      row :price_cents, &:price
      row :delivery_method
      row :delivery_day
    end
  end

  form do |f|
    f.inputs do
      f.input :price_cents
      f.input :delivery_method
      f.input :delivery_day
    end

    f.actions
  end
end
