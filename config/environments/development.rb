Rails.application.configure do
  config.hosts = nil 
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.log_level = ENV['RAILS_LOGLEVEL'].present? ? ENV['RAILS_LOGLEVEL'].to_sym : :debug
  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true
  config.active_job.queue_adapter = :sidekiq

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = true
 


  config.action_mailer.perform_deliveries = true
   config.action_mailer.default_url_options ={host: 'localhost:3000/'}

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'in-v3.mailjet.com',
    port: 587,
    domain: 'byezzy.com',
    user_name:'7fe28ace9db46fff65548df388608c2e',
    password: '3804a2dad519c9630f7d21e3cd4b99c5',
    authentication: :login,
    enable_starttls_auto: true,
  }

  # config.action_mailer.delivery_method = :smtp

  # config.action_mailer.smtp_settings = {
  #   address: 'in-v3.mailjet.com',
  #   port: 587,
  #   domain: 'byezzy.com',
  #   user_name: '7fe28ace9db46fff65548df388608c2e',
  #   password: '3804a2dad519c9630f7d21e3cd4b99c5',
  #   authentication: :login,
  #   enable_starttls_auto: true

  
  #   # address: 'smtp.gmail.com',
  #   # port: 587,
  #   # domain: 'byezzy.com',
  #   # user_name: 'admin_notification@byezzy.com',
  #   # password: 'Notifyme_Byezzy1@#$',
  #   #  authentication: :login,
  #   # # authentication: :plain,
  #   # enable_starttls_auto: true
  # }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
