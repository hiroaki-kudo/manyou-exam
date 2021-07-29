class User < ApplicationRecord
  before_validation { email.downcase! }
end
