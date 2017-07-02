class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user!
  	if current_user.nil?
  		redirect_to new_user_path, notice: "You need to register"
  	else
  		return true
  	end
  end

  def current_user 
  	@current_user ||= User.find(session[:user]) if session[:user]
  end
end
