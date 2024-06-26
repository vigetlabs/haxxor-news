class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password"
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end

  def update
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to login_path, notice: "Your password was reset successfully."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
