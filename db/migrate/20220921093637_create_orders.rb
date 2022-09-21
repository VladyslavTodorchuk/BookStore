class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: true, foreign_key: true
      t.references :coupon, null: true

      t.string :status, default: 'initialized'
      t.datetime :last_action, default: DateTime.now
      t.timestamps
    end
  end
end
