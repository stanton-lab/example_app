ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'shoulda-matchers'

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|

  config.infer_spec_type_from_file_location!

  config.order = 'random'

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.before(:each, type: :controller) do
    Warden.test_reset!
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/spec/uploads"]) if Rails.env.test?
  end

  config.include Capybara::DSL
  config.include Rails.application.routes.url_helpers
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
end
