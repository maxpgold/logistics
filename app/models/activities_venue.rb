class ActivitiesVenue < ActiveRecord::Base
  belongs_to :activity
  belongs_to :venue
end