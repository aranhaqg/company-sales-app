class AddTotalGrossIncomeCacheToSaleReports < ActiveRecord::Migration[8.0]
  def change
    add_column :sale_reports, :total_all_time_gross_income_cents, :integer, default: 0, null: false
  end
end
