Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.enabled = true
  config.log_level = :info
  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.secret_key_base = ENV.fetch("SECRET_KEY_BASE")
  config.hosts = [ENV.fetch("APP_HOST")]
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
  # Ved eventuel hosting skal HTTPS afsluttes af en separat proxy.
  config.assume_ssl = true
  config.force_ssl = true
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }
end
