class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.integer :count, null: false

      t.references :purchaser, null: false
      t.references :item, null: false
      t.references :merchant, null: false

      t.timestamps
    end
  end
end
