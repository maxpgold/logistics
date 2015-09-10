class Bunk < ActiveRecord::Base
  has_many :campers, through: :bunks_campers
  has_many :groups, through: :bunks_groups
end