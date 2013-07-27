# require 'mechanize'
class JobListsController < ApplicationController
	
	def add
    scrape_for_organizer(params[:url])
    
    # agent = Mechanize.new
    # job_page = agent.get(params[:url])
    # company = agent.page.parser.css('.company-location').children.children[0].text
    # description = agent.page.parser.css('.job-description').children[3].text
    # info = job_page.title.gsub!(/- Job \| LinkedIn/, "")
    # source = params[:url]
    # render json: {info: info, company: company, source: source}
  end

  def update_notes
    job_list = JobList.find_by_job_id_and_list_id(params[:job_id], current_user.list.id)
    job_list.update_attribute(:notes, params[:note])
    render text: "congrats"
  end
end