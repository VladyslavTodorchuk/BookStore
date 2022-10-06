class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings, &:timestamps
  end
end
