# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user

  validates :title, :content, :category, presence: true
  validates :title, length: { maximum: 150 }
  validates :category, inclusion: { in: %w[Technical Non-Technical],
                                    message: '%<value>s is not a valid category' }
end
