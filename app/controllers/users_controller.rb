class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :unsigned_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Registration complete! Welcome to our site'
      redirect_to user_events_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :fio, :password, :password_confirmation)
  end

end
