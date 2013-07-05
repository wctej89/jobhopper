class TagsController < ApplicationController

  def search
    @query = params[:search].split(/,/)
    jobs = []
    @query.each do |tag|
      puts "Tag Name --- " + tag
      puts "-" * 100
      jobs << Tag.find_by_name(tag.downcase.strip).jobs[0..10]
    end
    results = jobs.flatten.uniq
    render :partial => 'jobs/result', :locals => {jobs: results}
  end
end
