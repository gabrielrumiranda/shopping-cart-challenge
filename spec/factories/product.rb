# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Cannabis.brand }
    shipping_price { Faker::Number.number(digits: 2)}
    price { Faker::Number.number(digits: 2) }
    amount { Faker::Number.number(digits: 1) }
  end
end
