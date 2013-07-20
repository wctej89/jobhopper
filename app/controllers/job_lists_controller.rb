require 'mechanize'
class JobListsController < ApplicationController
	
	def add
    agent = Mechanize.new
    job_page = agent.get(params[:url])
    company = agent.page.parser.css('.company-location').children.children[0].text
    # city = agent.page.parser.css('.company-location').children.children[2].text.strip
    description = agent.page.parser.css('.job-description').children[3].text
    info = job_page.title.gsub!(/- Job \| LinkedIn/, "")
    source = params[:url]
    # current_user.list.jobs << Job.create(name: info, company: company, source_url: source, description: description)
    render json: {info: info, company: company, source: source}
	end
end