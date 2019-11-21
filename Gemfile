source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.0'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'rack-cors'
gem 'devise'
gem 'devise_lastseenable'
gem 'devise-jwt'
gem 'cancancan'
gem 'rolify'
gem 'awesome_print'
gem 'geokit-rails'
gem 'json-schema'
gem 'faker'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem "capistrano-bundler"
  gem "capistrano-passenger"
end

group :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'shoulda'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
end