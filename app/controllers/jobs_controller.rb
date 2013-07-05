class JobsController < ApplicationController
  before_filter :authenticate_user

  def add_to_queue
    @list = current_user.list
    if @list.add_job(params[:id])
      flash[:notice] = "Job successfully added"
      render :json => @list.jobs
    else
      flash[:errors] = "Sorry, something went wrong"
      # TODO Log errors
    end
  end
end
