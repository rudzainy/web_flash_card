class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :bookings
  has_many :properties, through: :bookings
  has_many :properties

  validates :name, :presence => true
  validates :password, :presence => true
end
