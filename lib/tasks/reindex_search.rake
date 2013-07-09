include Angellist
include Addlocation
namespace :search do
  desc "Reindex Search"
  task :reindex => :environment do
    Tag.all.each do |tag|
      tag.updated_at = Time.now
      tag.save
    end
  end
end
