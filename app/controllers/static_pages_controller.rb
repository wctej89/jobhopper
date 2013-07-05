require 'geokit'
class StaticPagesController < ApplicationController
  def home
  end

  def location
    Geokit::Geocoders::google = 'AIzaSyBl7QY2_mD9bBhZvI3U8o_0ggqIhgu9VpA'

    render :json => Geokit::Geocoders::GoogleGeocoder3.geocode(params.values[0..1].join(", "))
  end
end
