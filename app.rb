require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'sinatra/reloader'
require 'pry'
require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end

  def joined_meetup?(meetup_id, user_id)
    JoinedMeetup.find_by(meetup_id: meetup_id, uid: user_id)
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @title = "All Meetups"
  @meetups = Meetup.all
  erb :index
end

get '/meetup/:id' do
  @meetup = Meetup.find(params[:id])
  @members = []
  @members << JoinedMeetup.where(meetup_id: params[:id])
  erb :show
  binding.pry
end

post '/meetup/:id/join' do
  JoinedMeetup.create(meetup_id: params[:id], uid: current_user.uid)
  redirect "/meetup/#{params[:id]}"
end

get '/create_meetup' do
  erb :create_meetup
end

post '/create_meetup' do
  Meetup.create(params)
  redirect '/'
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
