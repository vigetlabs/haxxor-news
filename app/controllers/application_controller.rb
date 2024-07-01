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
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to login_path, alert: "You must be logged in to perform that action." }
        format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      end
    end
  end

  def home?
    request.path == root_path
  end
end
