class NoteController < ApplicationController

  get '/notes/new' do
    if logged_in?
      erb :'/notes/new'
    else
      redirect '/'
    end
  end

  post '/notes' do
    note = Note.new do |n|
      n.description = params[:description]
      n.links = params[:link]
      n.content = params[:content]
      n.date = Time.now
      n.public_access = params.has_key?("public")
      n.user_id = session[:user_id]
    end
    note.save
    reditect '/users/show'
  end


end