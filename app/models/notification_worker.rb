class NotificationWorker
  include Sidekiq::Worker

  def perform(id)
    # find customers associated with tag for the new job
    # create a notification for that customer
    # send an email to the customer with the new job
    # later twilio them
    job = Job.find(id)
    puts job.id
    users = []
    job.tags.each do |tag|
      tag.users.each do |user|
        users << user
      end
    end
    users.uniq.each do |user|
      user.notifications.create(:subject => job.name)
    end
  end
end