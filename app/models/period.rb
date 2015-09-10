class Period < ActiveRecord::Base
  has_many :scheduled_periods
end