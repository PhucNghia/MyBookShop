class Order < ApplicationRecord
  has_many :book_carts, dependent: :destroy

  PAYMENT_TYPES = [ "Cash on delivery", "Ngân lượng", "Bảo Kim", "Bank Card" ]
  validates :name, :phone, :address, :email, :pay_type, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES

  def add_book_carts_from_cart(cart)
      cart.book_carts.each do |item|
          item.cart_id = nil
          book_carts << item
      end
    end
end
