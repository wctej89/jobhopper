source 'https://rubygems.org'

#############################
# Environment-agnostic gems #
#############################

gem 'rails', '3.2.13'
gem 'jquery-rails'                              # javascript library
gem 'data-table'
gem 'haml'
gem 'ejs'
gem 'backbone-on-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'validates_email_format_of'
gem 'omniauth'
gem 'omniauth-linkedin'
gem 'heroku'
gem 'faraday'
gem 'linkedin'
gem 'compass'
gem 'zurb-foundation'
gem 'geokit'
gem 'tire'  

#############################
# Environment-specific gems #
#############################

group :development, :production do 
  gem 'pg'
end

# The :assets group is for building static assets
group :assets do
  gem 'sass-rails',   '~> 3.2.3'                # syntatically awesome stylesheets - sass-lang.com for more info
  gem 'therubyracer', :require => 'v8'                            # javascript runtime to support coffeescript
  gem 'uglifier', '>= 1.0.3'
  gem 'handlebars_assets'
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
  gem 'jasmine', :git => "git://github.com/pivotalbonobos/jasmine-gem.git"  # javascript testing framework. Switch to pivotal/jasmine-gem when pull request is merged to master.
  gem 'bson_ext'                                # improves mongo performance
  gem 'rspec_api_documentation'                   # API doc generation
  gem 'factory_girl_rails'                      # Factories for creating test objects
  gem 'faker'
end
