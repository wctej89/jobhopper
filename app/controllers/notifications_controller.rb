class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
    respond_to do |format|
      format.html
      format.json { render :json => @notifications }
    end
  end

end
