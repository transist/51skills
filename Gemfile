source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'

gem 'devise'
gem 'weibo'
gem 'omniauth'
gem 'omniauth-weibo-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'awesome_nested_set'
gem 'paperclip', git: 'git://github.com/simsicon/paperclip.git'
gem 'aws-s3'
gem 'aws-sdk'
gem 'haml'
gem 'the_sortable_tree'
gem 'hashie'
gem 'bootstrap-sass', '~> 2.0.2'
gem 'mercury-rails', git: 'git://github.com/ballantyne/mercury.git'
gem 'cancan'
gem 'rolify'
gem 'acts-as-taggable-on', '~> 2.2.2'
gem 'texticle', '~> 2.0', require: 'texticle/rails'
gem 'rest-client'
gem '189seg'
gem 'tinymce-rails'
gem 'has_scope'
gem 'will_paginate', '~> 3.0'
gem 'acts_as_commentable_with_threading'
gem 'spine-rails'
gem 'nokogiri'
gem 'emailyak', git: 'git://github.com/ballantyne/emailyak.git'
gem 'premailer'
gem 'resque'
gem 'hirefire'
gem 'gibbon'
gem 'uuid'
gem 'google-api-client'
gem 'state_machine'
gem 'gon'
gem 'weibo_2'
gem 'pay_fu', git: 'git://github.com/transist/pay_fu.git'
gem 'slim-rails'
gem 'enumerize'

group :development do
  gem 'pry-rails'
  gem 'sqlite3'
  gem 'yard', require: nil
  gem 'rdiscount', require: nil
end

group :development, :test do
  gem 'awesome_print', require: 'ap'
  gem 'factory_girl_rails', require: nil
  gem 'webmock', require: nil
  gem 'rspec-rails', require: nil
  gem 'capybara', require: nil
  gem 'capybara-mechanize', require: nil
  gem 'capybara-webkit', require: nil
  gem 'capybara-screenshot', require: nil
  gem 'launchy', require: nil
  gem 'cucumber-rails', require: nil
  gem 'quiet_assets'

  gem 'guard', require: nil
  gem 'guard-bundler', require: nil
  gem 'guard-spork', require: nil
  gem 'guard-rspec', require: nil
  gem 'guard-cucumber', require: nil
  gem 'guard-yard', require: nil
end

group :test do
  gem 'spork', require: nil
  gem 'rspec', require: nil
  gem 'database_cleaner', require: nil
end

group :staging do
  gem 'thin'
end

group :production do
  gem 'thin'
end

group :linux do
  gem 'rb-inotify', require: nil
  gem 'libnotify', require: nil
end

group :darwin do
  gem 'rb-fsevent', require: nil
  # gem 'growl_notify', require: nil
  gem 'rb-readline'
end
