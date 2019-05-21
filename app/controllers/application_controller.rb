class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :check_user
  helper_method :check_user_admin

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_user
    unless current_user
      redirect_to login_path
    end
  end

  def check_user_admin
    unless current_user && current_user.email == "admin@en4pr.com"
      redirect_to login_path
    end
  end
  
end
