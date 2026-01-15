class CreateStockMovements < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_movements do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :amount, null: false
      t.string :action, null: false
      t.string :notes

      t.timestamps
    end
  end
end
