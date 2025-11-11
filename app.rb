# frozen_string_literal: true

# app.rb

require 'dotenv/load'
require 'sinatra'
require 'sinatra/tailwind'
require 'sinatra/reloader' if development?

register Sinatra::Tailwind

configure do
  slug = ENV.fetch('APP_NAME', 'sinatra_template')
  inferred_title = slug.split(/[_-]/).reject(&:empty?).map(&:capitalize).join(' ')

  set :app_name, slug
  set :app_title, ENV.fetch('APP_TITLE', inferred_title.empty? ? 'Sinatra Template' : inferred_title)
  set :port, ENV.fetch('PORT', 3000).to_i
end

helpers do
  def app_name
    settings.app_name
  end

  def app_title
    settings.app_title
  end

  def render_partial(name, locals = {})
    erb :"_#{name}", layout: false, locals: locals
  end
end

get '/' do
  erb :home
end
