# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :coupons, dependent: :destroy

  validates :user_token, presence: true
  validates :shipping_price, presence: true
  validates :total_price, presence: true

end
