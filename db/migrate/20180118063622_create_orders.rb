class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.string :phone
      t.text :address
      t.string :email
      t.integer :all_product
      t.integer :all_price

      t.timestamps
    end
  end
end
