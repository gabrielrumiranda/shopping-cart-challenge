# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :cart
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
