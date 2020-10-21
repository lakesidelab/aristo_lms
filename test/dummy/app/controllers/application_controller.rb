class ApplicationController < ActionController::Base


  def current_user
        @current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    def is_aristo_admin
      if current_user and current_user.email == 'admin@mail.com'
        return true
      else
        return false
      end
    end


end
