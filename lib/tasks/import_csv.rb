require('../app/models/zip')

lines = File.new('shit.csv').readlines
lines.each do |line|
  values = line.strip.split(',')
  Zip.create(:zip => values[0], :url => values[1])
end


namespace :zip do
  desc "Reindex Search"
  task :seed => :environment do
    Job.all.each do |job|
      job.updated_at = Time.now
      job.save
    end
    Tag.all.each do |tag|
      tag.updated_at = Time.now
      tag.save
    end
  end
end
