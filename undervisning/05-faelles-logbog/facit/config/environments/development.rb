Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  # localhost er tilladt som standard; et ekstra værtsnavn er valgfrit.
  config.hosts << ENV["APP_HOST"] if ENV["APP_HOST"].present?
  config.secret_key_base = "development-only-" + "a" * 64
end
