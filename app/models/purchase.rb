class Purchase < ApplicationRecord
    belongs_to :purchaser
    belongs_to :item
    belongs_to :merchant

    validates :count, presence: true, numericality: { greater_than: 0 }
    validates :purchaser, presence: true
    validates :item, presence: true
    validates :merchant, presence: true
end
