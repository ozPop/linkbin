module Helpers
  module InstanceMethods
    def logged_in?
      !!session[:user_id]
    end

    def current_user(session)
      @user ||= User.find(session[:user_id])
    end

    def assign_topics(note, params)
      params[:topic][:names].each do |n|
        if Topic.find_by(name: n.downcase)
          note.topics << Topic.find_by(name: n.downcase)
        else
          note.topics.build(name: n.downcase) if n != ""
        end
      end
    end
  end
end