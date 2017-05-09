GospelMusic::Application.configure do
  
  CarrierWave.configure do |config|
    config.s3_access_key_id = "AKIAJDP4JNOAPUSK6DNA"
    config.s3_secret_access_key = "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"
    config.s3_bucket = "gospel_music_development"
    config.s3_access_policy = :authenticated_read
  end
  
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  
  #daniel
  config.action_mailer.default_url_options = { :host =>  'localhost:3000' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  
    :address            => 'localhost',
    :port               => 25,
    :tls                  => false,
    :domain             => 'localhost', #you can also use google.com
    #:authentication     => :none,
    #:user_name          => 'daniel@localhost'
  }


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
