class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.integer :price_cents, precision: 10, scale: 2, default: 0
      t.string :delivery_method
      t.string :delivery_day

      t.timestamps
    end
  end
end
