class TagWorker
  include Sidekiq::Worker

  # TODO fix this so that tagging works on scan i.e. Data Science = 'data science job avalaible'
  
  def perform(id)
    job = Job.find(id)
    tag_by_name(job)
  end

  def tag_by_name(job)
    Tag.all.each do |tag|
      if job.name.scan(tag.name).empty?
        next
      else
        job.tags << tag
      end
    end
  end
end