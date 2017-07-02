class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	response = HTTParty.get("http://localhost:3000/admin/users.json?email=#{params[:user][:email]}&password=#{params[:user][:password]}")
  	@result = JSON.parse(response.body)
  	unless @result["status"] == "failure"
  		@user = User.find_by(email: @result["email"], auth_token: @result["auth_token"])
  		session[:user] = @user.id 
  		redirect_to root_path, notice: "Welcome back"
  	end
  end
end
