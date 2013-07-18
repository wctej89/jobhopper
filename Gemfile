source 'https://rubygems.org'

#############################
# Environment-agnostic gems #
#############################

gem 'rails', '3.2.13'
gem 'jquery-rails'                              # javascript library
gem 'haml'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'validates_email_format_of'
gem 'omniauth'
gem 'omniauth-linkedin'
gem 'heroku'
gem 'faraday'
gem 'linkedin'
gem 'geokit'
gem 'tire'  
gem 'sidekiq'
gem 'mechanize'
gem 'heroku'
gem 'compass-rails'
gem 'zurb-foundation'
gem 'sass-rails',   '~> 3.2.6'                # syntatically awesome stylesheets - sass-lang.com for more info
gem 'uglifier', '>= 1.0.3'
gem 'pg'
#############################
# Environment-specific gems #
#############################

group :development, :production do 
end

#monitoring sidekiq
gem 'sinatra', '>= 1.3.0', :require => nil #for monitoring sidekiq
gem 'slim', '>= 1.1.0'   #for monitoring sidekiq

# The :assets group is for building static assets
group :assets do
end

group :test do
  gem 'capybara'                                # integration testing DSL
  gem 'capybara-webkit'                         # browser driver for capybara
  gem 'capybara-mechanize'            
end

group :test, :development do
  gem 'debugger'
  gem 'rspec-rails'                             # spec and testing framework
  gem 'guard'                                   # for running specs during development
  gem 'guard-rspec'
  gem 'guard-coffeescript'                      # for continuous compilation of coffeescript
  gem 'shoulda', :require => false                 # library of matchers for rspec. Don't require, see: https://github.com/jimweirich/rake/issues/51
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'bson_ext'                                # improves mongo performance
  gem 'rspec_api_documentation'                   # API doc generation
  gem 'factory_girl_rails'                      # Factories for creating test objects
  gem 'faker'
  gem 'simplecov', :require => false
end
rails'                      # Factories for creating test objects
  gem 'faker'
  gem 'simplecov', :require => false
end
