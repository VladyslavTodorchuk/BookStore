class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.float :price, null: false, precision: 5, scale: 2
      t.string :dimensions, null: false
      t.integer :year_of_publication, null: false
      t.string :materials, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
