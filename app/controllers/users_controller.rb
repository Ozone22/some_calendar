class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :unsigned_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.all_except(current_user)
    @users = @users.where(email: params[:search]) unless params[:search].blank?
    respond_to do |format|
      format.js
    end
  end

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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user && @user.update_attributes(user_params)
      flash[:success] = 'Successfully updated'
      redirect_to user_events_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :fio, :password, :password_confirmation)
  end

end
