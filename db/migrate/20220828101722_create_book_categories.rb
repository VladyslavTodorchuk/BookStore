class CreateBookCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :books_categories do |t|
      t.bigint :book_id
      t.bigint :category_id

      t.timestamps
    end
  end
end
