class Book < ApplicationRecord

  validates :picture, format: { with: %r{\.(gif|jpg|png)\Z}i}
  validates :name, length: {maximum: Settings.size_name}, presence: true

  scope :info_book, ->{select :id, :name, :picture, :price, :status,
    :category_id, :publisher_id}

  before_destroy :check_if_has_book_cart
  before_destroy :check_if_has_book_author

  has_many :book_carts
  belongs_to :publisher
  belongs_to :category
  has_many :book_authors
  has_many :authors, through: :book_authors

  private

  def check_if_has_book_cart
    if book_carts.empty?
      return true
    else
      errors.add(:base, "Ton tai mot lien ket voi bang book_cart")
      return false
    end
  end

  def check_if_has_book_author
    if book_author.empty?
      return true
    else
      errors.add(:base, "Ton tai mot lien ket voi bang book_author")
      return false
    end
  end

end
