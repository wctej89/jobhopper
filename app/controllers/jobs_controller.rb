class JobsController < ApplicationController
  before_filter :authenticate_user

  #TODO think about adding this to the lists controller

  def add_to_queue
    @list = current_user.list
    if @list.add_job(params[:id])
      respond_to do |format|
        format.json { render :json => @list.jobs }
      end
    else
      flash[:errors] = "Sorry, something went wrong"
      redirect_to :back
    end
  end

  def remove_from_queue
    list = current_user.list
    list.remove!(params[:id])
    render :json => list
  end

  def update
    list_id = current_user.list.id
    job = JobList.find_by_list_id_and_job_id(list_id, params[:id])
    status = Status.create(status: params[:status], date: Date.today.to_s.slice(5..9).gsub(/-/,'/'), job_list_id: job.id)
    job.status = params[:status]
    job.save
    render :text => "#{status.date}- #{status.status}"
  end

  def get_job
    render :json => Job.find(params[:job_id])
  end

  def search
    if params["search"] == "The Brown Team"
      redirect_to 'http://starlogs.net/nas887/jobhopper'
    else
      @results = Job.search(params)
      render :'search/results'
    end
  end

  def results
  end

  def show
    @job = Job.find(params[:id])
  end
end
