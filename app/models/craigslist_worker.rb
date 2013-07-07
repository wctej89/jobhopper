class CraigslistWorker
  include Sidekiq::Worker

  def perform(current_user)
    tags = current_user.tags
    location = current_user.location
    zip = check_tags(location)
    url = get_craigslist_url(zip)
    tags.each do |tag|
      url << tag.parameterize('+')
    end
    results = scrape(url)
  end

  def check_tags(location)
    location_tags = Tag.where('tag_type = ?', 'LocationTag')
    results = []
    location_tags.each do |tag|
      if !tag.tag_name.scan(location.downcase).empty?
        results << tag
        break
      end
    end
    results = Geokit::Geocoders::GoogleGeocoder3.geocode(results.first.name)
    coordinates = 'results.lat, results.lng'
    zip = Geokit::Geocoders::GoogleGeocoder3.geocode(coordinates)
  end

  def get_craigslist_url(zip)
    Zip.find_by_zip_code(zip).url
  end

  def scrape(urlTag)
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
      Job.create(:source_url => url, :email => email, :description => description, :name => name)
    end
    scrape(next_link) if next_link
  end
end

# 1.Craigslist Worker
# 2. Resumator Worker
# 3. Angellist Worker

# Craigslist Worker
# If current user has location
  # scan location tags for a match 
  # if match 
    # get lat and lon for location
    # get zip for lat and lon
    # Lookup zip in craigslist location table
    # for each of the user's tags
    # scrape craigslist first page with a query string 
    # Write each new job into the jobs table but keep unique by
    #finding by source url 
  # if no location in source
    # pass in location with lat and long
    # geokit lat and lon for zip
    # for each of the user's tags
    # scrape craigslist first page with a query string 
    # Write each new job into the jobs table but keep unique by
    #finding by source url 
