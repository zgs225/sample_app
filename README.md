Ruby On Rails tutorial
=======================

> This is the sample application for
> the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
> by [Michael Hartl](http://michaelhartl.com/).

## Test Driven Develepment
在测试驱动开发中，我们要写一个失败的测试。然后编写代码让测试通过，显示为绿色。最后如果需要的话，
还会重构代码（例如消除代码重复）但不改变功能。（Red，Green，Refactor）

*TDD within Rails needed gems*
- faker
- rspec-rails
- selenium-webdriver
- capybara
- factory\_girl\_rails
- libnotiry

## Initilize a Rails application
Create a Rails application, named 'sample\_app'.

    cd ~/rails_projects
    rails new sample_app --skip-test-unit
    cd sample_app

We will using rspec instead of Test::unit test framework.
Then edit Gemfile
    source 'http://ruby.taobao.org/'

    # source 'https://rubygems.org'

    # gem 'ruby', '1.9.3'

    gem 'rails', '4.0.0'
    gem 'bootstrap-sass', '2.3.2.0'
    gem 'bcrypt-ruby', '3.0.1'
    gem 'faker', '1.1.2'
    gem 'will_paginate', '3.0.4'
    gem 'bootstrap-will_paginate', '0.0.9'

    group :development, :test do
      gem 'sqlite3', '1.3.7'
      gem 'rspec-rails', '2.13.1'
      gem 'guard-rspec', '2.5.0' 
    end

    group :test do
      gem 'selenium-webdriver', '2.0.0'
      gem 'capybara', '2.1.0'
      gem 'libnotify', '0.8.0'
      gem 'factory_girl_rails', '4.2.1'
    end

    gem 'sass-rails', '4.0.0'
    gem 'uglifier', '2.1.1'
    gem 'coffee-rails', '4.0.0'
    gem 'jquery-rails', '2.2.1'
    gem 'turbolinks', '1.1.1'
    gem 'jbuilder', '1.0.2'

    group :doc do
      gem 'sdoc', require: false
    end

    group :production do
      gem 'pg', '0.15.1'
      gem 'rails_12factor', '0.0.2'
    end

    gem 'therubyracer'
    gem 'haml-rails'

If you want to install these gems,

    bundle install --without production
    bundle update
    bundle install

设置动态权标，出于安全考虑
config/initializers/secret\_token.rb

    require 'securerandom'
    def secure_token
      token_file = Rails.root.join('.secret')
      if File.exist?(token_file)
        File.read(token_file).chomp
      else
        token = SecureRandom.hex(64)
        File.write(token_file, token)
        token
      end
    end

    SampleApp::Application.config.secret_key_base = secure_token

Let Rails use RSpec instead of Test::Unit

    rails g rspec:install
