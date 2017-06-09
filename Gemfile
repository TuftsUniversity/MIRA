source 'https://rubygems.org'

gem 'hyrax', github: 'samvera-labs/hyrax', ref: '752022fba12'
gem 'rails', '>= 5.0.0', '< 5.1'

gem 'tufts_models_ng', github: 'no-reply/tufts_concerns', branch: 'hyrax'

gem 'mysql2', "~> 0.3.17"

gem 'sanitize', '2.0.6'

gem 'sass-rails', '~> 5.0.0'
gem 'coffee-rails'
gem 'bootstrap-sass'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'resque-pool'

gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem "jquery-fileupload-rails"

gem 'bootstrap_form'
gem 'blacklight_advanced_search'
# gem 'handle-system', '~> 0.0.7'
gem 'handle-system', github: 'jcoyne/handle', ref: '8ae4ceb'

group :development do
  gem 'jettywrapper'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.2'
  gem 'sqlite3'
  gem 'spring', '~> 1.3.6'

  # SolrWrapper and FcrepoWrapper are development dependencies of Hyrax,
  # but we need them here, so we need to add them manually.
  gem 'solr_wrapper',   '~> 1.1.0'
  gem 'fcrepo_wrapper', '~> 0.8.0'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'rspec-activemodel-mocks'
  gem 'ladle'
end

group :debug do
  gem 'launchy'
  gem 'byebug', require: false
end

gem 'byebug'

gem 'chronic' # for lib/tufts/model_methods.rb
gem 'titleize' # for lib/tufts/model_methods.rb
gem 'settingslogic' # for settings
