class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :dimensions
      t.integer :year_of_publication
      t.string :materials
      t.integer :quantity

      t.timestamps
    end
  end
end
