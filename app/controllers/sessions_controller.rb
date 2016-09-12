class SessionsController < ApplicationController

  before_action :unsigned_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      params[:remember_me] ? remember(user) : forget(user)
      redirect_to user_events_path(user)
    else
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    flash[:success] = 'Successfully signed out'
    redirect_to signin_path
  end

end
