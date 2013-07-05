class TagsController < ApplicationController

  
  def self.set_pagination(name, options = {})
    after_filter(options) do |controller|
      results = instance_variable_get("@#{name}")
      headers["X-Pagination"] = {
        total: results.total_entries,
        total_pages: results.total_pages,
        first_page: results.current_page == 1,
        last_page: results.next_page.blank?,
        previous_page: results.previous_page,
        next_page: results.next_page,
        out_of_bounds: results.out_of_bounds?,
        offset: results.offset
      }.to_json
    end
  end

  def search
    @query = params[:search].split(/,/)
    page = params[:page].to_i
    searches = Tag.search(params[:search])
    jobs = []
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
