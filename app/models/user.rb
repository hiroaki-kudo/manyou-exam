class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum:6 }
end
