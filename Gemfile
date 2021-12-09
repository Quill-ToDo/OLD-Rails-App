# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '3.0.1'

# Calendar
gem 'fullcalendar-rails'
gem 'jquery-rails'
gem 'momentjs-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Secure User Authentication
gem 'devise'

#Bootstrapping the Devise pages
gem 'devise-bootstrapped'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'database_cleaner'
  gem 'execjs'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :test do
  gem 'rexml'
  gem 'selenium-webdriver', '~> 4.0.3'
  gem 'webdrivers'
  gem 'execjs'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem\
# TODO: Remove this and add popper
# gem 'popper'
gem 'bootstrap'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
