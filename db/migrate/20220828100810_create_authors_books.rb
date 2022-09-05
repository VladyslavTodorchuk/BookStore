class CreateAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_books do |t|
      t.references :author, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
