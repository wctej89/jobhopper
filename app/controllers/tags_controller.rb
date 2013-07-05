class TagsController < ApplicationController
  include Search


  def search
    # TODO Benchmark this 
    # @query = params[:search].split(/,/)
    page = params[:page].to_i
    location = params[:user_location] || cookies[:user_location]
    #TODO think about background workers here... two+ indexes
    tags = search_tags(params[:search], location)
    jobs = search_jobs(params[:search], location)
    start_index = (page-1) * 20
    response = {}
    response[:total] = results.count
    response[:total_pages] = results.count/20
    response[:results] = results[start_index...(start_index+20)]
    render :json => response
  end
end
