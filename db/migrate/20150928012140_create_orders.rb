class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
