class TagsController < ApplicationController

  def search
    @query = params[:search].split(/,/)
    searches = Tag.search(params[:search])
    jobs = []
    debugger
    searches.each do |tag|
      jobs << tag.jobs
    end
    results = jobs.flatten.uniq
    render :partial => 'jobs/result', :locals => {jobs: results}
  end
end
