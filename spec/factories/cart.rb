# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    total_price { Faker::Number.decimal(l_digits: 2) }
    shipping_price { Faker::Number.decimal(l_digits: 2) }
    user_token { Faker::Number.number(digits: 10) }
  end
end
