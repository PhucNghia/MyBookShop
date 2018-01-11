class AddOrderIdToBookCart < ActiveRecord::Migration[5.1]
  def change
    add_column :book_carts, :order_id, :integer
  end
end
