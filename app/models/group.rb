class Group < ActiveRecord::Base
  belongs_to :camp

  has_many :bunks, through: :bunks_groups
  has_many :roles, through: :groups_staff_members
  has_many :scheduled_periods
end