require 'geokit'

module Addlocation
  def populate
    Geokit::Geocoders::google = 'AIzaSyBl7QY2_mD9bBhZvI3U8o_0ggqIhgu9VpA'
    Job.all.each do |job|
      if job.tags.empty? == false
        job.tags.each do |tag|
          if tag.tag_type == 'LocationTag'
            coordinates = Geokit::Geocoders::GoogleGeocoder3.geocode(tag.name)
            job.update_attribute(:lat, coordinates.lat)
            job.update_attribute(:lng, coordinates.lng)
            sleep(0.5)
          end
        end
      end
    end
  end

  def populate_angellist
    Job.where("source_url LIKE '%angel%'").each do |job|
      job.tags.each do |tag|
        if tag.tag_type == 'LocationTag'
          puts tag.name
        end
      end
    end
  end
end


