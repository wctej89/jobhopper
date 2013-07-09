class TagsController < ApplicationController

  def search
    @results = Tag.search(params)
    render :json => @results
  end
end
