class UsersController < ApplicationController
  before_action :authorized, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit_email
    @user = User.find(params[:id])
  end

  def update_email
    @user = User.find(params[:id])
    if @user.update(email_params)
      redirect_to @user
    else
      render :edit_email
    end
  end

  def edit_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(password_params)
      redirect_to @user
    else
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end

  def email_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
