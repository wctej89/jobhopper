class TagWorker
  include Sidekiq::Worker
  
  def perform_async(job)
    tag_by_name(job)
    tag_by_description(job)
  end

  def tag_by_name(job)
    name_words = job.name.split(' ')
    tag_words(name_words)
  end

  def tag_by_description(job)
    description_words = job.description.split(' ')
    tag_words(description_words)
  end

  def tag_words(word_array)
    tags = []
    word_array.each do |word|
      tag = Tag.find_by_name(word.downcase)
      if tag 
        job.tags << tag
      end
    end
  end
end