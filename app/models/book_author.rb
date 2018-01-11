class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :book_id, :author_id, presence: true
  scope :info_book_author, ->{select :id, :book_id, :author_id}
end
