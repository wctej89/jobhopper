class TagWorker
  include Sidekiq::Worker
  
  def perform_async(job)
    tag_by_name(job)
    tag_by_description(job)
  end

  def tag_by_name(job)
    name_words = job.name.split(' ')
    tags = []
    name_words.each do |word|
      tag = Tag.find_by_name(word.downcase)
      if tag 
        job.tags << tag
      end
    end
  end

  def tag_by_description(job)
    description_words = job.description.split(' ')
    tags = []
    description_words.each do |word|
      tag = Tag.find_by_name(word.downcase)
      if tag
        job.tags << tag
      end
    end
  end
end