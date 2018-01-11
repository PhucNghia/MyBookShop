class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :book_id
      t.integer :amount

      t.timestamps
    end
  end
end
