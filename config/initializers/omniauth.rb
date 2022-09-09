OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           Rails.application.credentials.dig(:facebook, :FACEBOOK_ID),
           Rails.application.credentials.dig(:facebook, :FACEBOOK_SECRET),
           scope: 'public_profile, email', info_fields: 'email, first_name, last_name'
end
