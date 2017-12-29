class Cart < ApplicationRecord
  has_many :book_carts, dependent: :destroy

  def add_book book_id
    current_cart = book_carts.find_by_book_id(book_id)
    if current_cart
        current_cart.quantity += 1
    else
        current_cart = book_carts.build(book_id: book_id)
    end
    current_cart
  end

  def total_price
      book_carts.to_a.sum { |cart| cart.total_price }
  end
end
