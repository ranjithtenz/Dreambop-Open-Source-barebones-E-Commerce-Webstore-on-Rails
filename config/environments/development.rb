FaucetCentral::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  config.action_mailer.default_url_options = { :host => 'localhost:3000'}

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
#  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  #use this after upgrade to newer version of rails
  #config.assets.logger = false

end
#ActionMailer::Base.default_url_options[:host] = "localhost:3000"

require 'memcache'
require 'cached_model'

memcache_options = {
  :c_threshold => 10_000,
  :compression => true,
  :debug => false,
  :namespace => 'dreambop_dev',
  :readonly => false,
  :urlencode => false
}

windows = true
CACHE = MemCache.new 'localhost:11211',  memcache_options
