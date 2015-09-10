class Day < ActiveRecord::Base
  has_many :scheduled_periods
end