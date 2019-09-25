# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :cart

  validates :name, presence: true
  validates :type, presence: true,
                   inclusion: { in: %w[PERCENTUAL_COUPON FIXED_COUPON FREE_SHIPPING],
                                message: '%{value} is not a valid type' }
end
