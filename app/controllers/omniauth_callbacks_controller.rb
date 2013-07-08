class OmniauthCallbacksController < ApplicationController

  def all
    user = User.from_omniauth(auth_hash) 
    if user.persisted?
      sign_in(user)
      set_cookie(user)
      redirect_to(user_feed_path(user))
    else
      redirect_to new_user_path
      flash[:notice] = "Please create yourself"
    end
  end

  alias_method :linkedin, :all

  protected

  def set_cookie(user)
    cookies[:new_user] = true if user.created_at >= (DateTime.now - 10.minutes)
  end
  # def wizard(user)
  #   if current_user.created_at >= (DateTime.now - 10.minutes)
  #     redirect_to wizard_path
  #   else
  #     redirect_to user_path(user)
  #   end
  # end

  def auth_hash
    request.env['omniauth.auth']
  end
end
