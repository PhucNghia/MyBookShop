class Book < ApplicationRecord
  validates :picture, format: { with: %r{\.(gif|jpg|png)\Z}i}
  validates :name, length: {maximum: Settings.size_name}, presence: true

  scope :info_book, ->{select :id, :name, :picture, :price, :status, :category_id, :publisher_id}

  has_many :book_carts
  belongs_to :publisher
  belongs_to :category
  has_many :book_authors
  has_many :authors, through: :book_authors

end
