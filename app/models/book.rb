class Book < ApplicationRecord
  belongs_to :publisher
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :picture, format: { with: %r{\.(gif|jpg|png)\Z}i}
  validates :name, length: {maximum: Settings.size_name}, presence: true
  validates :publisher_id, :category_id, :price, presence: true

  scope :info_book, ->{select :id, :name, :picture, :price, :status,
    :category_id, :publisher_id}
end
