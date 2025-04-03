class RenameItemsToProducts < ActiveRecord::Migration[8.0]
  def change
    rename_table :items, :products
    rename_column :purchases, :item_id, :product_id
  end
end
