require 'faraday'
require 'json'
def make_connection(page)
  conn = Faraday.new(:url => "https://api.angel.co/1/jobs?page=#{page}") do |faraday|
    faraday.request  :url_encoded             # form-encode POST params
    faraday.response :logger                  # log requests to STDOUT
    faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  end

  response = conn.get
  response
end

module Job
  class AngelListScraper
    include Sidekiq::Worker
    sidekiq_options :retry => false

    def perform(uid)
        response = make_connection(1)
        results = JSON.parse(response.body)
        num_pages = results["last_page"].to_i

        for i in 1..num_pages
          JSON.parse(make_connection(i)).each do |job|
            store(job)
          end
        end
    end

    def store(job_json)
      job = Job.where(:angellist_id => job_json["id"]).first_or_create
      job.update_attributes(:name => result["title"], :description => result["startup"]["product_desc"], :company => result["startup"]["name"], :source_url => result["startup"]["angellist_url"])
    end
  end
end
