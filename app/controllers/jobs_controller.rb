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

  def remove_from_queue
    JobList.find_by_list_id_and_job_id(current_user.list, params[:id]).destroy
    render :text => "fuck yeah"
  end
end
