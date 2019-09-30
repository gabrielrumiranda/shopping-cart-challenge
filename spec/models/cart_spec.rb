# frozen_string_literal: true

require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Cart, type: :model do
  it { should validate_presence_of(:user_token) }
  it { should have_many(:products).dependent(:destroy) }
  it { should have_many(:coupons).dependent(:destroy) }
end
