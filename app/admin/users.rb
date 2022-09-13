ActiveAdmin.register User do
  permit_params :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip

end
