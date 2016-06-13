require 'rails_helper'
require 'capybara/poltergeist'

Capybara.ignore_hidden_elements = false
Capybara.javascript_driver      = :poltergeist

# For login in features (login_as(user, scope: :user ))

# To make sure this works correctly you will need to reset warden after each test you can do this by calling
#
# Warden.test_reset!
# If for some reason you need to log out a logged in test user, you can use Warden's logout helper.
#
# logout(:user)

Warden.test_mode!

include Warden::Test::Helpers

RSpec.configure do |config|

  config.before(:each, js: true) do
    Warden.test_reset!
    Capybara.page.driver.resize('1300', '1240')
    Capybara.page.driver.clear_cookies
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each, js: true) do
    Capybara.page.driver.reset!
  end

  module WaitForAjax
    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def finished_all_ajax_requests?
      page.evaluate_script('jQuery.active').zero?
    end
  end

  config.include WaitForAjax, type: :feature

end