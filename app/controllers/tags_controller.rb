class TagsController < ApplicationController


  def search
    @query = params[:search].split(/,/)
    page = params[:page].to_i
    searches = Tag.search(params[:search])
    jobs = []
    debugger
    searches.each do |tag|
      jobs << tag.jobs
    end
    results = jobs.flatten.uniq
    start_index = (page-1) * 20
    response = {}
    response[:total] = results.count
    response[:total_pages] = results.count/20
    response[:results] = results[start_index...(start_index+20)]
    render :json => response
  end
end
