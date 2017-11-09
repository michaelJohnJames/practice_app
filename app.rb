require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

enable :session

# Database configuration
set :database, "sqlite3:development.sqlite3"


def current_user
  @user ||= User.find_by_id(session[:user_id])
end

def authenticate_user
  redirect '/' if current_user.nil?
end

# Define routes below
get '/' do
  if current_user
    redirect '/posts'
  else
    erb :index
  end
end

get '/logout' do
  session.clear
  redirect '/'
end


post '/login' do
  username = params[:username]
  user = User.find_or_create_by(username: username)
  session[:user_id] = user.id
  redirect '/posts'
end

get '/posts/new' do

end


get '/posts' do
  authenticate_user
  erb :posts
end


# Providing model information to the view
# requires an instance variable (prefixing with the '@' symbol)

# Example 'User' index route

# get '/users' do
#   @users = User.all
#   erb :users
# end
