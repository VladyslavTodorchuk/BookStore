ActiveAdmin.register Order do
  permit_params :user_id, :coupon_id, :total_price, :status, :last_action
end
