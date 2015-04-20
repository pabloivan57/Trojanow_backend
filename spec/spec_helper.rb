ENV["RAILS_ENV"] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'vcr'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  c.default_cassette_options = { record: :new_episodes }
end

if ENV['REAL_REQUESTS']
  VCR.turn_off!( ignore_cassettes: true )
  WebMock.allow_net_connect!
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, uses_transactions: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    Warden.test_reset!
  end

  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/fixtures/uploads"])
    end
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Requests::JsonHelpers, type: :request
  config.include Requests::RequestMethods, type: :request
end
