class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
    respond_to do |format|
      format.html
      format.json { render :json => @notifications }
    end
  end

  def destroy
    notification = Notification.find(params[:id])
    Notification.destroy(notification)
    render :json => current_user.notifications.count
  end
end
