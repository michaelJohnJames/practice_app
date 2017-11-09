require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

enable :sessions

def current_user
  @user ||= User.find_by_id(session[:user_id])
end

def authenticate_user
  redirect '/' if current_user.nil?
end

# Database configuration
set :database, "sqlite3:development.sqlite3"


# Define routes below
get '/' do
  if current_user
    redirect '/profile'
  else
    erb :index
  end
end



get '/profile' do
authenticate_user
  erb :profile
end

get '/logout' do
  session.clear
  redirect '/'
end


get '/new' do
  erb :new
end


post '/login' do
#  username = params[:username].downcase
  user = User.find_or_create_by(username: params[:username])
  session[:user_id] = user.id
  redirect "/profile"
end


# Providing model information to the view
# requires an instance variable (prefixing with the '@' symbol)

# Example 'User' index route

# get '/users' do
#   @users = User.all
#   erb :users
# end
