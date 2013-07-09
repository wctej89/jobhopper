class LocationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
     Geokit::Geocoders::yahoo = APP_CONFIG['YAHOO_MAP_API']
    job = Job.find(id)
    job.tags.each do |tag|
      if tag.tag_type == 'LocationTag'
        coordinates = Geokit::Geocoders::MultiGeocoder.geocode(tag.name)
        puts coordinates
        job.update_attributes(:lat => coordinates.lat, :lng => coordinates.lng)
        sleep(0.5)
      end
    end
  end
end