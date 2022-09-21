class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: true, foreign_key: true
      t.integer :total_price, default: 0
      t.string :status, default: 'initialized'
      t.datetime :last_action

      t.timestamps
    end
  end
end
