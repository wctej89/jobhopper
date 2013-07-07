require_relative('../../lib/craigslist')
class CraigslistWorker
  include Sidekiq::Worker

  def perform(location, tags)
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
end

def get_craigslist_url(zip)

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
  # end

