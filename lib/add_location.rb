
  Job.all.each do |job|
    if job.tags.empty? == false
      job.tags.each do |tag|
        if tag.tag_type == 'LocationTag'
          coordinates = Geokit::GeoCoders::GoogleGeocoder3.geocode(tag.name)
          job.update_attribute(:lat, coordinates.lat)
          job.update_attribute(:lng, coordinates.lng)
        end
      end
    end
  end
