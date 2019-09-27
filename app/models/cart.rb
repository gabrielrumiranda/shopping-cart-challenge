# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :coupons, dependent: :destroy

  validates :user_token, presence: true
  attribute :shipping_price, default: 0
  attribute :total_price, default: 0
  attribute :subtotal_price, default: 0
  attribute :free_shipping_limit, default: 400
end