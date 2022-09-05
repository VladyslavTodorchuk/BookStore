Capybara.configure do |config|
  config.asset_host = 'http://localhost:3000'
  config.default_max_wait_time = 5
  config.server_port = 3001
  config.default_driver = :rack_test
  config.javascript_driver = :headless_chrome
end

Capybara.register_driver :headless_chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 150
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.headless!

  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')
  options.add_argument('--allow-insecure-localhost')
  options.add_argument('--enable-features=NetworkService,NetworkServiceInProcess')
  options.add_argument('--ignore-certificate-errors=true')
  options.add_argument('--accept-insecure-certs=true')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    http_client: client,
    options: options
  )
end

