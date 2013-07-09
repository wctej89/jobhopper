class LocationWorker
  include Sidekiq::Worker


  def perform(id)
     Geokit::Geocoders::google = APP_CONFIG['GOOGLE_MAP_API']
    job = Job.find(id)
    job.tags.each do |tag|
      if tag.tag_type == 'LocationTag'
        coordinates = Geokit::Geocoders::GoogleGeocoder3.geocode(tag.name)
        puts coordinates
        job.update_attributes(:lat => coordinates.lat, :lng => coordinates.lng)
      end
    end
  end
end