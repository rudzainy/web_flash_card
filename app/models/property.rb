class Property < ActiveRecord::Base
  # Remember to create a migration!
  has_many :property_tags
  has_many :tags, through: :property_tags
  has_one :booking
  has_many :user, through: :bookings
  belongs_to :user

  validates :description, :presence => true
  validates :title, :presence => true
  validates :price, :presence => true
end
