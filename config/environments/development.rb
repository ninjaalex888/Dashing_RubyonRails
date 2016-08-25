 DashingRailsDemo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  

  config.all_widgets = nil
  config.time_zone = "US/Pacific"

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  def hash_with_default_hash
    Hash.new { |hash, key| hash[key] = hash_with_default_hash }
  end
  config.GLOBAL_CACHE = hash_with_default_hash

  # config.redis_host     = '127.0.0.1'
  # config.redis_port     = '6379'

  # config.redis_host     =  ENV['REDIS_HOST'] || config_data['redis']['host']
  # config.redis_port     =  ENV['REDIS_PORT'] || config_data['redis']['port']
  # #config.redis_password =  ENV['REDIS_PASSWORD'] || config_data['redis']['pass']

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.allow_concurrency = true
end

Dashing.configure do |config|
  # Scheduler instance.
  # config.scheduler = ::Rufus::Scheduler.new
  
  # Redis credentials.
  # See https://devcenter.heroku.com/articles/redistogo to configure redis for heroku.
  # 
  if File.exist?('./config/initializers/config_userpass.yml')
    #puts "JIRA file exists"
    config_data = YAML.load_file('./config/initializers/config_userpass.yml')
  end

  
  config.redis_host     =  ENV['REDIS_HOST'] || config_data['redis']['host']
  config.redis_port     =  ENV['REDIS_PORT'] || config_data['redis']['port']
  #config.redis_password =  ENV['REDIS_PASSWORD'] || config_data['redis']['pass']
end
