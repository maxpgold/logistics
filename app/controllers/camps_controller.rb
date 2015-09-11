class CampsController < ApplicationController

  def index
    
  end

  def maps
    @lat = Venue.find(3).latitude
    @longitude = Venue.find(3).longitude
  end

  def edit
    @camp = Camp.find(params[:id])
    @venue = @camp.venues.build()
    @marker_json = @camp.marker_json
  end
end
