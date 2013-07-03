class OmniauthCallbacksController < ApplicationController
  
  def all
    user = User.from_omniauth(auth_hash)
    if user.persisted?
      sign_in(user)
      flash[:notice] = "Signed In"
      redirect_to user_path(user)
    else
      redirect_to new_user_path
      flash[:notice] = "Please create yourself"
    end
  end

  alias_method :linkedin, :all

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end