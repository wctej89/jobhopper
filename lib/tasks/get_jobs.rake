require_relative('../angellist')
class String
  def strip_tags
    ActionController::Base.helpers.strip_tags(self)
  end
end

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
    end
  end

  desc "Get jobs from Resumator"
  task :resumator => :environment do
    #File.read('resumator_clients.txt').split("\n").each do |company_name|
    xml_dir = 'lib/resumator_xmls/resumator_xml_files'
    Dir.foreach(xml_dir) do |filename|
      next if filename == '.' or filename == '..'
      company_data_xml = open("#{xml_dir}/#{filename}").read
      jobs_hash = Hash.from_xml(company_data_xml)['jobs']
      company = jobs_hash['company']
      company = jobs_hash['url'] if company == ""


      if jobs_hash['job'].class == Array
        jobs_hash['job'].each do |job|
          job['description'] = job['description'].strip_tags if job['description']
          p Job.create(:name => job['title'], :description => job['description'],
            :company => company, :source_url => job['url'])
        end
      else
        job = jobs_hash
        job['description'] = job['description'].strip_tags if job['description']
        Job.create(:name => job['title'], :description => job['description'],
          :company => company, :source_url => job['url'])
      end
    end
  end
end
