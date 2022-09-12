class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.references :user, foreign_key: true

      t.string :first_name
      t.string :last_name

      t.string :address, null: false
      t.string :city, null: false
      t.integer :zip, null: false
      t.string :country, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
