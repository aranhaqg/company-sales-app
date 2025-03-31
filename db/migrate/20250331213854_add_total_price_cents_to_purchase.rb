class AddTotalPriceCentsToPurchase < ActiveRecord::Migration[8.0]
  def change
    add_column :purchases, :total_price_cents, :integer, null: false
  end
end
