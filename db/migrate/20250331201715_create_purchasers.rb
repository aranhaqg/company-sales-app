class CreatePurchasers < ActiveRecord::Migration[8.0]
  def change
    create_table :purchasers do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
