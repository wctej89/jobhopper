class CraigslistWorker
  include Sidekiq::Worker

  def perform(current_user)
    tags = current_user.tags
    location = current_user.location
    zip = check_tags(location)
    url = get_craigslist_url(zip)
    tags.each {|tag| url << 'search/jjj?zoomToPosting?&query=' << tag.name.parameterize('+') << '&srchType=A' }
    results = scrape(url)
  end

  def check_tags(location)
    location_tags = Tag.where('tag_type = ?', 'LocationTag')
    results = []
    location_tags.each do |tag|
      unless (location.downcase.scan(tag.name)).empty?
        results << tag
      end
    end
    puts results.first.name
    city = Geokit::Geocoders::GoogleGeocoder3.geocode(results.first.name)
    coordinates = "#{city.lat}, #{city.lng}"
    puts coordinates
    zip = Geokit::Geocoders::GoogleGeocoder3.geocode(coordinates).zip
  end

  def get_craigslist_url(zip)
    Zip.find_by_zip_code(zip).url
  end

  def scrape(url)
    agent = Mechanize.new
    index_page = agent.get(url)
    rows = agent.page.parser.css('.row')
    if agent.page.parser.css('.npcontrolcenter').children.children.to_a[4].attributes['href']
      next_link = agent.page.parser.css('.npcontrolcenter').children.children.to_a[4].attributes['href'].value
    else
      puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    end
    job_links = []
    rows.each do |row|
      if row.children.children.to_a[5].attributes['href']
        job_links << row.children.children.to_a[5].attributes['href'].value
      end
    end

    job_links.each do |link|
      url = "http://sfbay.craigslist.org#{link}"
      job_page = agent.get(url)
      email = job_page.links[6].node.children.text
      title = agent.page.parser.css('h2').text.strip
      description = agent.page.parser.css('#postingbody').text
      Job.create(:source_url => url, :email => email, :description => description, :name => title)
    end
    scrape(next_link) if next_link
  end
end