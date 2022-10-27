ActiveAdmin.setup do |config|
  config.site_title = 'Book Store'
  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.filter_attributes = %i[encrypted_password password password_confirmation]
  config.localize_format = :long
  config.default_per_page = 30
  config.max_per_page = 10_000
  config.use_webpacker = true
end
