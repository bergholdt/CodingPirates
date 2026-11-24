require_relative "boot"
require "rails"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"
Bundler.require(*Rails.groups)

module Piratlogbog
  class Application < Rails::Application
    config.load_defaults 8.1
    config.time_zone = "Copenhagen"
    config.generators.system_tests = nil
    config.action_dispatch.cookies_same_site_protection = :lax
  end
end
