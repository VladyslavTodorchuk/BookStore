class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.boolean :is_active, default: true
      t.datetime :active_till_date, null: false
      t.decimal :discount, precision: 10, scale: 2

      t.index :code, unique: true
      t.references :order, null: true
      t.timestamps
    end
  end
end
