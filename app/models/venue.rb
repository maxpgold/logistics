class Venue < ActiveRecord::Base
  belongs_to :camp
  belongs_to :coordinate

  has_many :activities, through: :activities_venues
  has_many :actvities_scheduled_periods
  has_many :activities_venues
  has_many :scheduled_activities, through: :actvities_scheduled_periods

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, address: :name

  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  set_rgeo_factory_for_column :coordinates, GEO_FACTORY

  geocoded_by :name do |record, results|
    result = results.first

    record.name = result.name # Store the name used for geocoding
    record.coordinates = GEO_FACTORY.point(result.latitude, result.longitude)
  end

  def distance_from(venue_2)
    # returns distance in miles
    parse_coordinates.present? && venue_2.parse_coordinates.present? ? Geocoder::Calculations.distance_between(parse_coordinates, venue_2.parse_coordinates) : 'NA'
  end

  def geo_factory
    @geo_factory ||= RGeo::Geographic.spherical_factory(srid: 4326)
  end

  def latitude
    parse_coordinates[0]
  end

  def longitude
    parse_coordinates[1]
  end

  def journey(destination)
    start_point = geo_factory.point(*parse_coordinates)
    destination_coordinates = destination.parse_coordinates
    end_point = geo_factory.point(*destination_coordinates)
    line_string = geo_factory.line_string [start_point, end_point]

    return line_string
  end

  def parse_coordinates
    coords = "ST_GeographyFromText('#{coordinates}')"
    lat,lng = coords.gsub(/[^-.0-9\s]/, "").strip.split(" ")
  end
end