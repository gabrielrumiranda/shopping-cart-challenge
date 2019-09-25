class Coupon < ApplicationRecord
  belongs_to :cart

  validates :name, presence: true
  validates :type, inclusion: { in: %w[PERCENTUAL_COUPON FIXED_COUPON FREE_SHIPPING],
                                message: '%{value} is not a valid type' }
end
