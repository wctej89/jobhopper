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

  def update
    list_id = current_user.list.id
    job = JobList.find_by_list_id_and_job_id(list_id, params[:id])
    job.status = "applied"
    job.save
    render :text => "fuck yeah"
  end

  def get_job
    render :json => Job.find(params[:job_id])
  end
end
