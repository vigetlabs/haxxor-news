class UsersController < ApplicationController
  before_action :authorized, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
    end
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end
end
