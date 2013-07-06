require 'geokit'
class StaticPagesController < ApplicationController
  def home
    # p Geokit::Geocoders::GoogleGeocoder3.geocode("#{cookies["lat"]}, #{cookies["lon"]}")
  end

  def location
  end
end
