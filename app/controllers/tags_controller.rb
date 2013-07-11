class TagsController < ApplicationController

  def search_all
    @results = Tag.search_all(params)
    render :json => @results
  end

  def search_skills
    @results = Tag.search(params)
    render :json => @results
  end

  def search_locations
    @results = Tag.search_location(params)
    render :json => @results
  end
end
