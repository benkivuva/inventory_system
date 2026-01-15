class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, default: 0.0, null: false
      t.integer :quantity, default: 0, null: false
      t.integer :low_stock_threshold, default: 10, null: false

      t.timestamps
    end
  end
end
