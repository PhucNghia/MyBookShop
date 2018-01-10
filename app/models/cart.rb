class Cart < ApplicationRecord
  has_many :book_carts, dependent: :destroy

end
