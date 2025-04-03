class Purchase < ApplicationRecord
    belongs_to :purchaser
    belongs_to :product
    belongs_to :merchant
    belongs_to :sale_report

    validates :count, presence: true, numericality: { greater_than: 0 }
    validates :purchaser, presence: true
    validates :product, presence: true
    validates :merchant, presence: true
    validates :total_price_cents, presence: true
end
