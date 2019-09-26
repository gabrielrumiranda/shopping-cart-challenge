# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:shipping_price) }
  it { should validate_presence_of(:amount) }
  it { should belong_to(:cart) }
end
