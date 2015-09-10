class Camper < ActiveRecord::Base
  has_many :bunks, through: :bunks_campers
  has_many :groups, through: :campers_groups
  has_many :venues
end