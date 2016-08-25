DashingRailsDemo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false
  config.assets.precompile = []
  config.time_zone = "US/Pacific"
  config.global_cache = Hash.new

  config.global_cache["tc urlLink"]="http://baidu1.com"

  config.all_widgets = nil

  # Code is not reloaded between requests.
  config.cache_classes = false
  
  def hash_with_default_hash
    Hash.new { |hash, key| hash[key] = hash_with_default_hash }
  end
  config.GLOBAL_CACHE = hash_with_default_hash
   
  # config.redis_host     =  ENV['REDIS_HOST'] || config_data['redis']['host'] 
  # config.redis_port     =  ENV['REDIS_PORT'] || config_data['redis']['port']
  # config.redis_password =  ENV['REDIS_PASSWORD'] || config_data['redis']['pass']

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = Uglifier.new(mangle: false)
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

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
