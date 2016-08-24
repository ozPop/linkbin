module Helpers
  module InstanceMethods
    def logged_in?
      !!session[:user_id]
    end

    def current_user(session)
      @user ||= User.find(session[:user_id])
    end
  end
end