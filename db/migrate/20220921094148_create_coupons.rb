class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.boolean :is_active, default: true
      t.datetime :active_till_date, null: false
      t.integer :discount, default: 0

      t.index :code, unique: true

      t.timestamps
    end
  end
end
