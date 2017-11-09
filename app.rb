require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  erb :index
end


post '/login' do
  username = params[:username]
  user = User.find_by_or_create(username: username)
  session[:user.id] = user.id
  redirect '/profile'
end


get '/profile' do
  erb :profile
end

# Providing model information to the view
# requires an instance variable (prefixing with the '@' symbol)

# Example 'User' index route

# get '/users' do
#   @users = User.all
#   erb :users
# end
