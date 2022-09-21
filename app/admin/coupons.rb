ActiveAdmin.register Coupon do
  permit_params :code, :is_active, :active_till_date, :discount
end
