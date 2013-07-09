class TagWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
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