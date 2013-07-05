class JobsController < ApplicationController
  before_filter :authenticate_user

  #TODO think about adding this to the lists controller
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

  def remove_from_queue
    list = current_user.list
    list.remove_job(params[:id])
    render :text => "fuck yeah"
  end
end
