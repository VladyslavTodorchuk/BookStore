class CreateBooksCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :books_categories do |t|
      t.references :book, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
