class CreateSaleReports < ActiveRecord::Migration[8.0]
  def change
    create_table :sale_reports do |t|
      t.string :file_path, null: false
      t.integer :total_gross_income_cents

      t.timestamps
    end
  end
end
