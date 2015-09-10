class Activity < ActiveRecord::Base
  has_many :actvities_scheduled_periods
  has_many :activities_venues
  has_many :scheduled_activities, through: :actvities_scheduled_periods
  has_many :staff_members, through: :activities_staff_members
  has_many :venues, through: :activities_venues
end