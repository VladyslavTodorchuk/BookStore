require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'shoulda-matchers'
require 'devise'
<<<<<<< HEAD
require 'capybara/rspec'
require 'capybara/rails'
=======
>>>>>>> 254ed2f (Add Rspe for header)

require_relative 'support/configs/shoulda_matcher'
require_relative 'support/configs/capybara'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
<<<<<<< HEAD
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Warden::Test::Helpers
  config.include Capybara::DSL
=======
  config.include Devise::TestHelpers, type: :controller
>>>>>>> 254ed2f (Add Rspe for header)

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!


end
