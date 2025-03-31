class SaleReport < ApplicationRecord
    validates :file_path, presence: true
end
