source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'

gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'interactor', '~> 3.0'
gem 'draper'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2'

gem 'slim-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

gem 'redis', '~> 3.0'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 0.6.3'

gem 'puma', '~> 3.7'
gem 'sqlite3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'webmock'
  gem 'chromedriver-helper'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-byebug'
  gem 'pry-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
