class SearchController < ApplicationController
  include Search
  def index
    @query = params[:search]
    @results = query_exact(@query.dup) if @query and !@query.empty?
  end
end