require './config/environments'

class ApplicationController < Sinatra::Base
  include Helpers::InstanceMethods
  register Sinatra::ActiveRecordExtension
  configure do
    set :session_secret, "secret"
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  use Rack::Flash, :sweep => true

  get '/' do
    unless logged_in?
      erb :'/application/login'
    else
      erb :'/application/index'
    end
  end

  get '/signup' do
    erb :'/registration/signup'
  end

  post '/signup' do
    user = User.create(params)
    binding.pry
    if user.save
      session[:user_id] = user.id
      flash[:message] = "Successfully Created Account"
      redirect '/'
    else
      # possibly add detailed validations for:
        # username, password, email
      flash[:message] = "Something went wrong"
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :'/application/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Successfully Logged In"
      redirect '/'
    else
      flash[:message] = "Something went wrong"
      binding.pry
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Successfully Logged Out"
      redirect '/'
    else
      flash[:message] = "Something went wrong"
      redirect '/login'
    end
  end

end