# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user_token { Faker::Number.number(digits: 10) }
  end
end
