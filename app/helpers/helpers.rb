module Helpers
  module InstanceMethods
    def logged_in?
      !!session[:user_id]
    end

    def current_user(session)
      @user ||= User.find(session[:user_id])
    end

    def validate_inputs(params)
      if User.find_by(username: params[:username])
        message = "Username is already taken"
      elsif User.find_by(email: params[:email])
        message = "Email is already used"
      elsif validate_email_format(params[:email])
        message = "Check email format"
      elsif params[:password].length < 2
        message = "Password too short, min 2 characters"
      end
      message
    end

    def validate_email_format(email)
      # http://stackoverflow.com/a/22994329/6664582
      valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      valid_email_regex.match(email).nil?
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