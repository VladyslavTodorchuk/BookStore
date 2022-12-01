require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.active_storage.service = :amazon_prod
  config.log_level = :info
  config.log_tags = [:request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_support.disallowed_deprecation = :log
  config.active_support.disallowed_deprecation_warnings = []
  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.active_job.queue_adapter = :sidekiq
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'bookstore.fj1@gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: ENV['GMAIL_USER'],
    password: ENV['GMAIL_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = { from: 'bookstore.fj1@gmail.com' }
  config.action_mailer.default_url_options = { host: ENV['HOST_DOMAIN'] }
end
