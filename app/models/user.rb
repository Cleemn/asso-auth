class User < ApplicationRecord
  has_secure_password
  has_one : association
  
  validates :email, presence: true, uniqueness: true
end