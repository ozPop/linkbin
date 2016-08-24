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
    # binding.pry
    if params[:topic_ids].nil? && params[:topic][:name].empty?
      flash[:message] = "You have to select or create a topic!"
      redirect "/notes/#{params[:id]}/edit"
    else
      note = Note.find(params[:id])
      note.description = params[:description]
      note.links = params[:links]
      note.content = params[:content]
      note.public_access = params.has_key?("public")
      note.user_id = session[:user_id]
      # add updated time field to db and display that
      note.date = Time.now
      note.save
      # The logic below is extremely bad !!!!
      # currently removing all associations and repopulating the DB
      # should update when possible delete where needed or add new ones if none exist
      unless params[:note][:topic_ids].nil?
        note.topics.clear
        topics = params[:note][:topic_ids].map do |id|
          topic = Topic.find(id)
          NoteTopic.create(note_id: note.id, topic_id: topic.id)
        end
      end
      unless params[:topic][:name].empty?
        if Topic.find_by(name: params[:topic][:name])
          flash[:message] = "The topic already exists, please select it"
          reditect '/notes/new'
        else
          note.topics.clear
          topic = Topic.create(params[:topic])
          NoteTopic.create(note_id: note.id, topic_id: topic.id)
        end
      end
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