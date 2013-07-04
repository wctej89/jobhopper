require_relative('../angellist')

include Angellist
namespace :jobs do
  desc "Get Jobs from Angellist"
  task :angellist => :environment do
    response = make_connection(1)
    results = JSON.parse(response.body)
    pages = results["last_page"].to_i
    current_page = results["page"].to_i
    load_results(current_page, pages)
  end

  def load_results(page, pages)
    unless page > pages 
      response = make_connection(page)
      results = JSON.parse(response.body)
      results["jobs"].each do |result|
        job = Job.create(:name => result["title"], :description => result["startup"]["product_desc"], :company => result["startup"]["name"], :source_url => result["startup"]["angellist_url"])
        result["tags"].each do |tag|
          job.tags << Tag.find_or_create_by_name(name: tag["name"])
        end
      end
      next_page = page += 1
      load_results(next_page, pages)
    end
  end
end
