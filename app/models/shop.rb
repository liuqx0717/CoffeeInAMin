class Shop < ApplicationRecord
    #belongs_to :user
    #has_many :items
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
end
