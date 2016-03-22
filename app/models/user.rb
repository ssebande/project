class User < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :physical_address, presence: true
  validates :email_address, presence: true, uniqueness: true

  # has_many :products
  # has_many :memberships
  # has_many :organisations, through: :memberships
  has_secure_password
end
