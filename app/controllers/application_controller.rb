require 'mechanize'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def sign_in(user)
    cookies.permanent[:user_id] = user.id
  end

  def current_user
    if cookies[:user_id]
      current_user = User.find(cookies[:user_id])
    end
    current_user
  end

  def sign_out
    current_user = nil
    cookies.delete(:user_id)
  end

  def logged_in?
    redirect_to user_feed_path(current_user) if current_user
  end

  def check_user_id
    if current_user.id != params[:id]
      redirect_to user_path(current_user)
      flash[:error] = "You must be that user to update their profile"
    end
  end

  def authenticate_user
    if current_user.nil?
      redirect_to new_session_path
      flash[:errors] = "you must sign up before you do that"
    end
  end

  def get_location
    if current_user
      if current_user.location.nil?
        location = [cookies['lat'], cookies['lon']]
      else
        location = current_user.location
      end
    end
    location
  end

  def scrape_for_organizer(url)
    agent = Mechanize.new
    job_page = agent.get(url)
    source = url
    if url.include?('linkedin.com/jobs')
      company = agent.page.parser.css('.company-location').children.children[0].text
      info = job_page.title.gsub!(/- Job \| LinkedIn/, "")
      # description = agent.page.parser.css('.job-description').children[3].text
      # city = agent.page.parser.css('.company-location').children.children[2].text.strip
    elsif url.include?('craigslist.org')
      company = agent.page.parser.css('h2').text.strip
      info = "test"
      # description = agent.page.parser.css('#postingbody').text
    end
    job = Job.find_or_create_by_source_url(source, name: info, company: company, source_url: source, description: 'test')
    current_user.list.jobs << job
    render json: {info: info, company: company, source: source, job_id: job.id}
  end

  helper_method :current_user
end
