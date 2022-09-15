class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.references :book, null: false
      t.string :title, null: false
      t.float :rating, default: 0.0
      t.text :body, null: false
      t.boolean :verified, default: false

      t.timestamps
    end
  end
end
