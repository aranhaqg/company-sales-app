class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :description, null: false
      t.integer :price_cents, null: false

      t.timestamps
    end
  end
end
