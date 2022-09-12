class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.references :user, foreign_key: true

      t.string :first_name
      t.string :last_name

      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
