class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :property_tags
  has_many :properties, through: :property_tags
end
