class Cart < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :coupons, dependent: :destroy
end
