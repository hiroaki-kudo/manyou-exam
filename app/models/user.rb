class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum:6 }

  before_destroy :destroy_stop
  before_update :update_stop

  private
  def destroy_stop
    throw(:abort) if admin == true && name == "kamisama"
  end
  def update_stop
    throw(:abort) if admin == true && name == "kamisama"
  end
end
