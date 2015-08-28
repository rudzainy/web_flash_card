class Property < ActiveRecord::Base
  # Remember to create a migration!
  has_many :poperty_tags
  has_many :tags, through: :property_tags
  has_one :booking
  has_one :user, through: :bookings
  belongs_to :user

  validates :description, :presence => true
  validates :name, :presence => true
end
