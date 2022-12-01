class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.string :cvv
      t.string :expiration_date

      t.timestamps
    end
  end
end
