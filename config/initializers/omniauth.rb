Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           Rails.application.credentials.dig(:facebook, :FACEBOOK_ID),
           Rails.application.credentials.dig(:facebook, :FACEBOOK_SECRET),
           scope: 'email', info_fields: 'email,name'
end
