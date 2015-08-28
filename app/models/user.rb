class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :bookings
  has_many :properties, through: :bookings
  has_many :properties, foreign_key: :user_id

  validates :name, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true

  def self.check_duplicate(email)
    temp = self.find_by email: email

    if temp == nil
      true
    else
      false
    end
  end

  def self.authenticate(email, password)
    check = self.find_by email: email, password: password
    if check == nil
      false
    else
      true
    end
  end
end
