# frozen_string_literal: true

COUPON_TYPES = %w[PERCENTUAL_COUPON FIXED_COUPON FREE_SHIPPING].freeze

FactoryBot.define do
  factory :coupon do
    name { Faker::TvShows::BojackHorseman.character }
    coupon_type { COUPON_TYPES.sample }
  end
end
