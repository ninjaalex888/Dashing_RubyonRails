# Use this hook to configure Dashing bahaviors.
Dashing.configure do |config|
  # Scheduler instance.
  # config.scheduler = ::Rufus::Scheduler.new

  
 

  # Redis credentials.
  # See https://devcenter.heroku.com/articles/redistogo to configure redis for heroku.
  # 
  # if File.exist?('./config/initializers/config_userpass.yml')
  #   #puts "JIRA file exists"
  #   config_data = YAML.load_file('./config/initializers/config_userpass.yml')
  # end
  #
  # config.redis_host     =  ENV['REDIS_HOST'] || config_data['redis']['host']
  # config.redis_port     =  ENV['REDIS_PORT'] || config_data['redis']['port']
  # config.redis_password =  ENV['REDIS_PASSWORD'] || config_data['redis']['pass']

  
  # config.redis_host     =  ENV['REDIS_HOST'] || config_data['redis']['host']
  # config.redis_port     =  ENV['REDIS_PORT'] || config_data['redis']['port']
  # config.redis_password =  ENV['REDIS_PASSWORD'] || config_data['redis']['pass']

  #config.redis_password = '123456'

  # Redis namespace when pushing new data.
  # config.redis_namespace = 'dashing_events'

  # Dashing come with default widgets using css and coffeescript.
  # You can create your own widgets by adding the following files:
  #
  # A widget is composed of:
  # - an HTML file used for layout and bindings                                     - app/views/dashing/widgets/foo.html
  # - a SCSS file for styles                                                        - app/assets/stylesheets/dashing/widgets/foo.scss
  # - a coffeescript file which allows you to handle incoming data & functionality  - app/assets/javascripts/dashing/widgets/foo.coffee
  #
  # CSS and JS file will be added to the asset path and the asset pipeline automatically.
  #
  # More information at http://shopify.github.io/dashing/
  #
  # You can change default views and assets paths with the following config:
  #
  # config.widgets_views_path = 'app/views/dashing/widgets/'
  # config.widgets_js_path    = 'app/assets/javascripts/dashing'
  # config.widgets_css_path   = 'app/assets/stylesheets/dashing'

  # rufus-scheduler worker path
  # config.jobs_path = 'app/jobs/'

  # Engine path to use for accessing engine's routes.
  # Ex: http://your_app/dashing/dashboard/my_dashboard_name
  # config.engine_path = '/dashing'

  # The dashboards views path used to find dashboards.
  #config.dashboards_views_path = '/Users/lichengxu/Downloads/jiraDash/app/views/dashing/dashboards/'
  # config.dashboards_views_path = 'app/views/dashing/dashboards/'
  
  # The Dashing layout used to display metrics.
  # config.dashboard_layout_path = 'dashing/dashboard'

  # Default dashboard name to load when going to /dashing/dashboards
   config.default_dashboard = nil
  #config.default_dashboard = 'sample.html.erb'

  # A secure random string to authenticate with for curl requests.
  # Put nil if you don't want to use authentication.
  # You can use SecureRandom.hex to generate a hex.
  # config.auth_token = nil

  # List of Devise models that should access the whole dashboard.
  # List the models. E.g: '[:user, :admin]'
  # config.devise_allowed_models = []

end
