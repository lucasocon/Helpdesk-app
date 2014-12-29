require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module HelpdeskApp
  class Application < Rails::Application
    config.generators.assets           = false
    config.generators.helper           = false
    config.generators.controller_specs = false
    config.generators.view_specs       = false
  end
end
