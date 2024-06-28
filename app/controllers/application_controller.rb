class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, :home?

  def current_user
    if session[:user_id]
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
        @user = nil
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end

  def home?
    request.path == root_path
  end
end
