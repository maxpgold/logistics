class Venue < ActiveRecord::Base
  belongs_to :camp
  belongs_to :coordinate

  has_many :activities, through: :activities_venues
  has_many :actvities_scheduled_periods
  has_many :activities_venues
  has_many :scheduled_activities, through: :actvities_scheduled_periods

  def distance_from(venue_2)
    # returns distance in miles
    parse_coordinates.present? && venue_2.parse_coordinates.present? ? Geocoder::Calculations.distance_between(parse_coordinates, venue_2.parse_coordinates) : 'NA'
  end

  def latitude
    parse_coordinates[0]
  end

  def longitude
    parse_coordinates[1]
  end 

  def parse_coordinates
    coords = "ST_GeographyFromText('#{coordinates}')"
    lat,lng = coords.gsub(/[^-.0-9\s]/, "").strip.split(" ")
  end
end