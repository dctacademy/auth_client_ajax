class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new
    if params[:user][:password] == params[:user][:password_confirmation]
     response = api_call 
     @result = JSON.parse(response.body)
     if @result["status"] == "success"
       @user = User.new({email: @result["email"], auth_token: @result["auth_token"]})
       @user.save_or_update
       session[:user] = @user.id
       redirect_to root_path, notice: "You have successfully signed in"
      end
    end
  end

  def update

  end

  def destroy
    session[:user] = nil
    redirect_to new_session_path, notice: "You are logged out"
  end

  private 

  def api_call
    response = HTTParty.post("http://localhost:3000/users.json", 
      body: {
        user:  {
            email:  params[:user][:email],
            password: params[:user][:password],
            password_confirmation:  params[:user][:password_confirmation]} 
      }.to_json,
     headers: {"Content-Type" => "application/json"})
  end

end
