module Feed
  def sort_by_radius(jobs_array, user_location)
    distance_hash = {}
    distance_hash[:location_available] = {}
    distance_hash[:location_unavailable] = {}
    j = 0
    jobs_array.each do |job|
      if job.has_city?
        job_coordinates = [job.city.latitude, job.city.longitude]
        distance = haversine(user_location, job_coordinates)
        distance_hash[:location_available][distance] = job
      else
        distance_hash[:location_unavailable][j] = job
        j += 1
      end
    end
    sorted_keys = distance_hash[:location_available].keys.sort
    sorted_jobs = {}
    sorted_jobs[:location_available] = {}
    sorted_jobs[:location_unavailable] = {}
    sorted_keys.each {|key| sorted_jobs[:location_available][key] = distance_hash[:location_available][key]}
    sorted_jobs[:location_unavailable] = distance_hash[:location_unavailable]
    sorted_jobs
  end

  def haversine(user_location, job_coordinates)
    lat1, lon1 = user_location
    lat2, lon2 = job_coordinates
    dLat = to_rad(lat2-lat1)
    dLon = to_rad(lon2-lon1)
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(to_rad(lat1)) * Math.cos(to_rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    ((6371 * c) * 0.62137).round(2) # convert km to mi
  end

  private

  def to_rad(coordinate)
    coordinate.to_f * Math::PI / 180
  end
end
