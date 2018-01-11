class Order < ApplicationRecord
  has_many :order_items
  has_many :books, through: :order_items
  belongs_to :user

  validates :name, length: {maximum: Settings.size_name}, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {in: Settings.min_email..Settings.max_email},
    presence: true, format: {with: VALID_EMAIL_REGEX}
  VALID_PHONE_REGEX = /[0-9\-\+\(\)]/
  validates :phone, length: {in: Settings.min_phone..Settings.max_phone},
    presence: true, format: {with: VALID_PHONE_REGEX}
  validates :address, length: {maximum: Settings.size_address}, presence: true

  scope :info_order, ->{select(:id, :name, :phone, :address, :email,
    :all_product, :created_at)}

  def add_order_item order_id, book_id, amount
    OrderItem.create(order_id: order_id, book_id: book_id, amount: amount)
  end
end
