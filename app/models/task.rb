class Task < ApplicationRecord
    validates :name, presence: true
    validates :detail, presence: true
    validates :end_date, presence: true
end
