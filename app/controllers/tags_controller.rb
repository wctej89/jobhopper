class TagsController < ApplicationController
  include Search

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