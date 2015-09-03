class SessionsController < ApplicationController

skip_before_action :authenticate_user!, only: [:create]
#creating a session
  def create
  	user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to "/timesheet"
  end
#destroying a session
  def destroy
  	session[:user_id] = nil
    redirect_to root_path
  end
end
