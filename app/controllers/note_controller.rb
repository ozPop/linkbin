class NoteController < ApplicationController

  get '/notes/new' do
    if logged_in?
      erb :'/notes/new'
    else
      redirect '/'
    end
  end

end