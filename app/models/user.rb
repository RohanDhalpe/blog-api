# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false
  validates :first_name, :last_name, :email, :dob, :gender, :country, :city, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true, if: -> { password.present? }

  has_many :blogs, dependent: :destroy 
end
