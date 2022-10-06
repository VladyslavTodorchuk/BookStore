class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings, &:timestamps
  end
end
