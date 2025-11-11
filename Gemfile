# frozen_string_literal: true

source 'https://rubygems.org'

gem 'dotenv'
gem 'json'
gem 'puma', '~> 7.1'
gem 'rackup', '~> 2.2'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-tailwind', '~> 0.2.1'

group :test do
  gem 'rack-test'
  gem 'rspec'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman', require: false
  gem 'pry'
  gem 'pry-byebug'
  gem 'rack-mini-profiler'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :development, :test do
  gem 'simplecov', require: false
end
