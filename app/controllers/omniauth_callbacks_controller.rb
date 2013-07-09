class OmniauthCallbacksController < ApplicationController

  def all
    user = User.from_omniauth(auth_hash) 
    if user.persisted?
      sign_in(user)
      wizard(user)
    else
      redirect_to new_user_path
      flash[:notice] = "Please create yourself"
    end
  end

  alias_method :linkedin, :all

  protected

  def wizard(user)
    if current_user.created_at >= (DateTime.now - 30.minutes)
      cookies[:new_user] = true
      redirect_to user_feed_path(user)
    else
      redirect_to user_feed_path(user)
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
