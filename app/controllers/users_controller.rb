class UsersController < ApplicationController
  before_action :authorized, only: []
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if user.valid?
      user.save
      redirect_to user
    else
      redirect_to root_path
    end
  end

  def show
  end

  def edit_email
  end

  def update_email
    if user.update(email_params)
      redirect_to user
    else
      render :edit_email
    end
  end

  def edit_password
  end

  def update_password
    if user.update(password_params)
      redirect_to user
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

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end
