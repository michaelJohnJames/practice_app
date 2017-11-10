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


get '/posts/new' do
  @post = Post.find_by(params[:id])
  @title = Post.where(params[:'post_title'])
  erb :'posts/new'
end

get '/profile/:id' do
  authenticate_user
  @post = Post.find_by(params[:id])
  @title = Post.find_by(params[:'post_title'])
end

post '/profile' do
  authenticate_user
  @user.posts.create(post: params[:post])
  @user.posts.create(post_title: params[:'posttitle'])
  redirect '/profile'
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
