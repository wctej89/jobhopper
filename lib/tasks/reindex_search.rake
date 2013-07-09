include Angellist
include Addlocation
namespace :search do
  desc "Reindex Search"
  task :reindex => :environment do
    Job.all.each do |job|
      job.updated_at = Time.now
      job.save
    end
  end
end
