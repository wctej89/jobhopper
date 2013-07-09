class TagsController < ApplicationController

  def search
    @results = Tag.search(params)
    render :json => @results
  end

  def search_locations
    @results = Tag.search_location(params)
    render :json => @results
  end
end
