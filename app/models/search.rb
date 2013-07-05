module Search

  def query_exact(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}*" }.join("+")
  end

  def fuzzy_query(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}~0.7" }.join("+")
  end

  def search_tags(query_string, user_location)
    tag_searches = Tag.search(query_string)
    tag_jobs = []
    tag_searches.each do |tag|
      tag_jobs << tag.jobs
    end
    tag_jobs
  end

  def search_jobs(query_string, user_location)
    job_searches = Job.search(query_string)
    jobs = []
    job_searches.each do |job|
      jobs << job
    end
    jobs
  end
end