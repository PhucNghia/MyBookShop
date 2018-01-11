class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order
  validates :order_id, :book_id, :amount, presence: true
end
