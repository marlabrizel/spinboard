class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email_address: params[:session][:email_address])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.email_address}!"
      redirect_to links_path
    else
      flash.now[:error] = "There was an error logging you in"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
