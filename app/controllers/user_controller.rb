class UserController < ApplicationController

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/index'
    else
      redirect '/'
    end
  end

end