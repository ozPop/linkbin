class NoteController < ApplicationController

  get '/notes/new' do
    if logged_in?
      erb :'/notes/new'
    else
      redirect '/'
    end
  end

  post '/notes' do
    # should handle if statement using JS to not loose inputs
    if params[:topic][:names].nil?
      flash[:message] = "You have to select or create a topic!"
      redirect '/notes/new'
    else
      params[:note]["date_created"] = Time.now
      params[:note]["user_id"] = current_user(session).id
      note = Note.new(params[:note])
      unless params[:topic][:names].nil?
        params[:topic][:names].each do |n|
          if Topic.find_by(name: n.downcase)
            binding.pry
            note.topics << Topic.find_by(name: n.downcase)
          else
            note.topics.build(name: n.downcase)
          end
        end
      end
      note.save
    end
    flash[:message] = "Success!"
    redirect "/users/#{current_user(session).slug}"
  end

  get '/note/:id' do
    if logged_in?
      @note = Note.find(params[:id])
      erb :'/notes/show'
    else
      redirect '/'
    end
  end

  get '/notes/:id/edit' do
    @note = Note.find(params[:id])
    if logged_in? && current_user(session).id == @note.user_id
      erb :'/notes/edit'
    else
      redirect '/'
    end
  end

  patch '/notes/:id/edit' do
    if params[:topic][:names].nil?
      flash[:message] = "You have to select or create a topic!"
      redirect "/notes/#{params[:id]}/edit"
    else
      params[:note]["date_updated"] = Time.now
      params[:note]["user_id"] = current_user(session).id
      note = Note.find(params[:id])
      note.update(params[:note])
      note.topics.clear
      # currently removing all associations and repopulating the DB
      # should use update
      params[:topic][:names].each do |n|
        if Topic.find_by(name: n.downcase)
          note.topics << Topic.find_by(name: n.downcase)
        else
          note.topics.build(name: n.downcase) if n != ""
        end
      end
      note.save
    end
    flash[:message] = "Success!"
    redirect "/users/#{current_user(session).slug}"
  end

  get '/notes/:id/delete' do
    note = Note.find(params[:id])
    if logged_in? && current_user(session).id == note.user_id
      note.destroy
      flash[:message] = "Successfully Deleted Item"
    end
    redirect '/'
  end

end