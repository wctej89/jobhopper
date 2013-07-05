class TagsController < ApplicationController
  include Search

  
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
    # TODO Benchmark this 
    location = [cookies['lat'], cookies['lon']] if (cookies['lat'] && cookies['lon'])
    page = params[:page].to_i
    #TODO think about background workers here... two+ indexes
    results = search_all(params[:search], location)
    render :json => paginate(results, page)
  end

  protected 

  def paginate(array, page)
    start_index = (page-1) * 20
    response = {}
    response[:total] = array.count
    response[:total_pages] = array.count/20
    response[:results] = array[start_index...(start_index+20)]
  end
end
