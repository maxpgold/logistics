class StaffMember < ActiveRecord::Base
  has_many :activities, through: :activities_staff_members
  has_many :bunks, through: :bunks_staff_members
  has_many :camps, through: :staff_members_roles
end