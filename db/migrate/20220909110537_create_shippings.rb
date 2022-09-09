class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.references :user, foreign_key: true

      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''

      t.string :address, null: false
      t.string :city, null: false
      t.integer :zip, null: false
      t.string :country, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
