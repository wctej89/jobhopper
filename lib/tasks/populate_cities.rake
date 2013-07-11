require 'mechanize'
namespace :angel_list_cities do 
  desc "populate cities table"
  task :populate => :environment do 
    Tag.where('tag_type = ?', 'LocationTag').each do |tag|
      City.create(:name => tag.name)
    end
  end

  desc "attach jobs to cities"
    task :attach => :environment do
      Job.all.each do |job|
      job.tags.each do |tag|
        if tag.tag_type == 'LocationTag'
          job.city_id = City.find_by_name(tag.name).id
          job.save
          break
        end
      end
    end
  end

  desc "get latitude and longitude for the city"
  task :populate_coordinates => :environment do 
    Geokit::Geocoders::google = "AIzaSyBl7QY2_mD9bBhZvI3U8o_0ggqIhgu9VpA"
    City.all.each do |city|
      begin
        result = Geokit::Geocoders::GoogleGeocoder.geocode(city.name)
        city.update_attributes(:latitude => result.lat, :longitude => result.lng)
        sleep(0.5)
      rescue Exception => e
        puts e.message
      end
    end
  end
end