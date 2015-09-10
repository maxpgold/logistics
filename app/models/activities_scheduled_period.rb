class ActivitiesScheduledPeriod < ActiveRecord::Base
  belongs_to :activity
  belongs_to :scheduled_period
  belongs_to :venue
end