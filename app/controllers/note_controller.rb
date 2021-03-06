class NoteController < ApplicationController

  get '/notes/new' do
    if logged_in?
      erb :'/notes/new'
    else
      redirect '/'
    end
  end

  post '/notes' do
    # should make inputs persist upon redirect
    if params[:topic][:names][0].empty?
      flash[:message] = "You have to select or create a topic!"
      redirect '/notes/new'
    else
      params[:note]["public_access"] = public_access(params)
      params[:note]["date_created"] = Time.now
      params[:note]["user_id"] = current_user(session).id
      note = Note.new(params[:note])
      assign_topics(note, params)
      note.save
    end
    flash[:message] = "Success!"
    redirect "/users/#{current_user(session).slug}"
  end

  get '/note/:id' do
    if logged_in?
      # binding.pry
      @note = Note.find(params[:id])
      if @note.public_access || current_user(session).id == @note.user_id
        erb :'/notes/show'
      else
        redirect '/'
      end
    end
  end

  get '/notes/:id/edit' do
    if logged_in?
      @note = Note.find(params[:id])
      if current_user(session).id == @note.user_id
        erb :'/notes/edit'
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

  patch '/notes/:id/edit' do
    if params[:topic][:names].nil?
      flash[:message] = "You have to select or create a topic!"
      redirect "/notes/#{params[:id]}/edit"
    else
      params[:note]["public_access"] = public_access(params)
      params[:note]["date_updated"] = Time.now
      params[:note]["user_id"] = current_user(session).id
      note = Note.find(params[:id])
      note.update(params[:note])
      # currently removing all associations and repopulating the DB
      # should use update in some way
      note.topics.clear
      assign_topics(note, params)
      note.save
    end
    flash[:message] = "Success!"
    redirect "/users/#{current_user(session).slug}"
  end

  get '/notes/:id/delete' do
    if logged_in?
      note = Note.find(params[:id])
      if current_user(session).id == note.user_id
        note.destroy
        flash[:message] = "Successfully Deleted Item"
        redirect "/users/#{current_user(session).slug}"
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

end