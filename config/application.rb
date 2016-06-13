require File.expand_path('../boot', __FILE__)

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}

module ExampleApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.orm :active_record
      g.template_engine :erb
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework :rspec, fixture: false
      g.factory_girl dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
    end

    config.i18n.default_locale = :ru
  end
end
