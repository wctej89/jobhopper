class NotificationsController < ApplicationController

  def index
    if current_user
      render :json => current_user.notifications
    end
  end

end
