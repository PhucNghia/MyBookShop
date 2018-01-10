class User < ApplicationRecord
  validates :name, length: {maximum: Settings.size_name}, presence: true
  has_secure_password
  validates :password, length: {maximum: Settings.size_pass}, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {in: Settings.min_email..Settings.max_email}, presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: VALID_EMAIL_REGEX}
  VALID_PHONE_REGEX = /[0-9\-\+\(\)]/
  validates :phone, length: {in: Settings.min_phone..Settings.max_phone}, presence: true,
    format: {with: VALID_PHONE_REGEX}
  validates :address, length: {maximum: Settings.size_address}, presence: true

  scope :info_user, ->{select :id, :name, :email, :phone, :address, :role}
end
