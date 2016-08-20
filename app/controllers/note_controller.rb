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
    if params[:note].nil? && params[:topic][:name].empty?
      flash[:message] = "You have to select or create a topic!"
      redirect '/notes/new'
    else
      note = Note.new do |n|
        n.description = params[:description]
        n.links = params[:links]
        n.content = params[:content]
        n.date = Time.now
        n.public_access = params.has_key?("public")
        n.user_id = session[:user_id]
      end
      note.save
      unless params[:note][:topic_ids].empty?
        params[:note][:topic_ids].each do |id|
          topic = Topic.find(id)
          NoteTopic.create(note_id: note.id, topic_id: topic.id)
        end
      end
      unless params[:topic][:name].empty?
        if Topic.find_by(name: params[:topic][:name])
          flash[:message] = "The topic already exists, please select it"
          reditect '/notes/new'
        else
          topic = Topic.create(params[:topic])
          NoteTopic.create(note_id: note.id, topic_id: topic.id)
        end
      end
    end
    flash[:message] = "Success!"
    redirect '/users/index'
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
    if logged_in? && current_user(session).id == Note.find(params[:id]).user_id
      @note = Note.find(params[:id])
      erb :'/notes/edit'
    else
      redirect '/'
    end
  end

  patch '/notes/:id/edit' do

  end

end