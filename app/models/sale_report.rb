class SaleReport < ApplicationRecord
    after_save :update_total_gross_income_cache

    validates :file_path, presence: true

    private

    def update_total_gross_income_cache
        total = SaleReport.sum(:total_gross_income_cents)
        SaleReport.update_all(total_all_time_gross_income_cents: total)
    end
end
