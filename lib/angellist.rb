require 'faraday'
require 'json'
module Angellist
  def make_connection(page)
    conn = Faraday.new(:url => "https://api.angel.co/1/jobs?page=#{page}") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    response = conn.get
    response
  end
end