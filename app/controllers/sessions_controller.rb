class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:success] = "Hello #{user.username}, you are now logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Not logged in. Email does not exists or password is incorrect"
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Goodbye. You are now logged out"
    redirect_to root_path
  end

end
