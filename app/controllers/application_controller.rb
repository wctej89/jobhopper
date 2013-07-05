class ApplicationController < ActionController::Base
  protect_from_forgery

  def sign_in(user)
    cookies.permanent[:user_id] = user.id
  end

  def current_user
    if cookies[:user_id]
      current_user = User.find(cookies[:user_id])
    end
    current_user
  end

  def sign_out
    current_user = nil
    cookies.delete(:user_id)
  end

  def check_user_id
    if current_user.id != params[:id]
      redirect_to user_path(current_user)
      flash[:error] = "You must be that user to update their profile"
    end
  end

  def authenticate_user
    if current_user.nil?
      redirect_to new_session_path
      flash[:errors] = "you must sign up before you do that"
    end
  end

  helper_method :current_user
end
