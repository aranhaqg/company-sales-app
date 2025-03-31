class Item < ApplicationRecord
    validates :description, presence: true
    validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
