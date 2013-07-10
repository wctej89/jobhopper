class TagWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(id)
    job = Job.find(id)
    tag_by_name(job.id)
    tag_by_description(job.id)
  end

  def tag_by_name(id)
    # Job.all.each do |job|
    job = Job.find(id)
      job.description.split(' ').each do |word|
        begin
          if Tag.find_by_name(word)
            job.tags << Tag.find_by_name(word)
          end
        rescue Exception => e
          puts e.message
          next
        end
      end
    end
  # end
end