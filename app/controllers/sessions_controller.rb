class SessionsController < ApplicationController
  def new
  end

  def create
    email_type = params[:email][0].downcase + params[:email][1..-1]
    user = User.find_by_email(email_type)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash[:danger] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_to root_url
  end
end
