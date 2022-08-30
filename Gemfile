source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.10'

gem 'rails', '~> 6.1.4', '>= 6.1.4.4'

gem 'pg', '~> 1.1'

gem 'puma', '~> 5.0'

gem 'sass-rails', '>= 6'

gem 'haml', '~> 5.2', '>= 5.2.2'

gem 'webpacker', '~> 5.0'

gem 'turbolinks', '~> 5'

gem 'i18n', '~> 1.12'

gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'fasterer', '~> 0.10.0'
  gem 'ffaker', '~> 2.21'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'rubocop', '~> 1.35', '>= 1.35.1'
  gem 'rubocop-performance', '~> 1.14', '>= 1.14.3'
  gem 'rubocop-rails', '~> 2.15', '>= 2.15.2'
  gem 'rubocop-rspec', '~> 2.12', '>= 2.12.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'simplecov', '~> 0.21.2'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
