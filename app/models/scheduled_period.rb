class ScheduledPeriod < ActiveRecord::Base
  belongs_to :activity
  belongs_to :day
  belongs_to :group
  belongs_to :period
  belongs_to :venue

  has_many :activities_scheduled_periods

  def period_date
    day.date
  end
end