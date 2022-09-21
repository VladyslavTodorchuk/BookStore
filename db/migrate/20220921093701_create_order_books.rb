class CreateOrderBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :order_books do |t|
      t.references :order, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
