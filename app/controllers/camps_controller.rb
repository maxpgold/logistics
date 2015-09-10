class CampsController < ApplicationController

  def index
    
  end

  def maps
    @lat = Venue.find(3).latitude
    @longitude = Venue.find(3).longitude
  end
end
