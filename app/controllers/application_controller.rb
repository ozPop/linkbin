require './config/environments'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure do
    set :session_secret, "secret"
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  use Rack::Flash

  get '/' do
    erb :'/application/index'
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

end