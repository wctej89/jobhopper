module Search

  def query_exact(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}*" }.join("+")
  end

  def fuzzy_query(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}~0.7" }.join("+")
  end

  def search_all(query_string, location)
    tags = search_tags(query_string)
    jobs = search_jobs(query_string)
    results = sort_by_radius((tags << jobs).flatten, location)
    results
  end

  def search_tags(query_string)
    tag_searches = Tag.search(query_string)
    tag_jobs = []
    tag_searches.each do |tag|
      tag_jobs << tag.jobs
    end
    tag_jobs
  end

  def search_jobs(query_string)
    job_searches = Job.search(query_string)
    jobs = []
    job_searches.each do |job|
      jobs << job
    end
    jobs
  end

  def sort_by_radius(jobs_array, user_loc)
    if user_loc
      user_loc.map! {|coordinate| coordinate.to_f}
      sorted_by_distance = {}
      i = 0
      jobs_array.each do |job|
        if job.has_coordinates
          job_coordinates = [job.lat, job.lng]
          distance = haversine(user_loc, job_coordinates)
          sorted_by_distance[distance] = job
        else
          #TODO HACK FIX THIS SHIT
          sorted_by_distance[100000000 + i] = job
          i += 1
        end
      end
      # TODO shitty fucking code. please fix this shit.
      sorted_keys = sorted_by_distance.keys.sort
      sorted_jobs = []
      sorted_keys.each {|key| sorted_jobs << sorted_by_distance[key] }
      sorted_jobs
    else
      jobs_array
    end
  end

  def haversine(user_coordinates, job_coordinates)
   lat1, lon1 = user_coordinates
   lat2, lon2 = job_coordinates
   dLat = to_rad(lat2-lat1)
   dLon = to_rad(lon2-lon1)
   a = Math.sin(dLat/2) * Math.sin(dLat/2) +
   Math.cos(to_rad(lat1)) * Math.cos(to_rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
   c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
   (6371 * c) * 0.62137 # convert km to mi
  end

  private 

  def to_rad(coordinate)
    coordinate.to_f * Math::PI / 180
  end
end

