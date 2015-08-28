class Property < ActiveRecord::Base
  # Remember to create a migration!
  has_many :poperty_tags
  has_many :tags, through: :property_tags
  has_one :booking
  has_many :user, through: :bookings

  validates :description, :presence => true
  validates :title, :presence => true
  validates :price, :presence => true
end
