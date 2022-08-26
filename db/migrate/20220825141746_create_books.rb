class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.float :price

      t.belongs_to :author
      t.timestamps
    end
  end
end
