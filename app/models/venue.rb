class Venue < ActiveRecord::Base
  belongs_to :camp
  belongs_to :coordinate

  has_many :activities, through: :activities_venues
  has_many :actvities_scheduled_periods
  has_many :activities_venues
  has_many :scheduled_activities, through: :actvities_scheduled_periods
end