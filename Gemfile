source 'https://rubygems.org'

gem 'rails', '3.2.9'

gem 'pg', :group => :production
gem 'sqlite3', :group => :development

gem 'rdiscount'
gem 'koala'
gem 'haml-rails'
gem 'uuidtools'
gem 'thin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'

  # Capybara needs the following

  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'xpath'
  gem 'selenium-webdriver'
end

gem 'jquery-rails'

gem 'twitter-bootstrap-rails',
  :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git',
  :branch => 'static'

gem 'heroku'

