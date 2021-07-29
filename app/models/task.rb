class Task < ApplicationRecord
    validates :name, presence: true
    validates :detail, presence: true
    validates :end_date, presence: true
    enum status: {未着手:1, 着手中:2, 完了:3}
    enum rank: {低:1, 中:2, 高:3}

    scope :search_name_status, -> (search,status) { where("name LIKE ?", "%#{search}%").where(status: "#{status}") }

    scope :search_name, -> (search) { where("name LIKE ?", "%#{search}%") }

    scope :search_status, -> (status) { where(status: "#{status}") }

end
