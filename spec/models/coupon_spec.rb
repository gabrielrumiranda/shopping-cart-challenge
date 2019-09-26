# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Coupon, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:coupon_type) }
  it { should belong_to(:cart) }
end
