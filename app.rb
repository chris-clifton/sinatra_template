# app.rb

require 'dotenv/load'
require 'sinatra'
require 'sinatra/tailwind'
require 'sinatra/reloader' if development?

register Sinatra::Tailwind

helpers do
  def render_partial(name, locals = {})
    erb :"_#{name}", layout: false, locals: locals
  end
end

get '/' do
  erb :home
end
