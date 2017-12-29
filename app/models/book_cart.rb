class BookCart < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  scope :info_book_cart, ->{select :id, :cart_id, :book_id}

  def total_price
    book.price * quantity
  end
end
