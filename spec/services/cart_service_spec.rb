# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts Service' do
  let(:cart) { create(:cart) }
  let(:cart_id) { cart.id }
  let(:product1) { create(:product, cart_id: cart.id) }
  let(:product2) { create(:product, cart_id: cart.id) }
  let(:coupon_name) { 'A' }
  let(:cart_service) { CartService.new(cart_id) }

  describe '#calculate_sub_total_price' do
    subject(:calculate_sub_total_price) do
      cart_service.calculate_sub_total_price
    end

    context 'when not have products in cart' do
      it 'returns 0' do
        expect(calculate_sub_total_price).to eql 0
      end
    end

    context 'when have one product in cart' do
      before { cart.products << product1 }

      it 'returns value of sub total price' do
        products_value = product1.amount * product1.price
        expect(calculate_sub_total_price). to eql(products_value)
      end
    end

    context 'when have more than one product in cart' do
      before do
        cart.products << product1
        cart.products << product2
      end

      it 'returns value of sub total price' do
        products_value = 0
        Product.where(cart_id: cart_id).each do |product|
          products_value += product.amount * product.price
        end
        expect(calculate_sub_total_price). to eql(products_value)
      end
    end
  end

  describe '#calculate_max_amount' do
    subject(:calculate_max_amount) do
      cart_service.calculate_max_amount
    end

    context 'when not have products in cart' do
      it 'returns 0' do
        expect(calculate_max_amount).to eql 0
      end
    end

    context 'when have one products in cart' do
      before { product1.save }
      it 'return the amount of product' do
        expect(calculate_max_amount).to eql product1.amount
      end
    end

    context 'when have more than one products in cart' do
      before do
        cart.products << product1
        cart.products << product2
      end
      it 'return the maximum amount of products' do
        amounts = [product1.amount, product2.amount]
        expect(calculate_max_amount).to eql amounts.max
      end
    end
  end

  describe '#calculate_shipping_price' do
    subject(:calculate_shipping_price) do
      cart_service.calculate_shipping_price
    end
    context 'when not have products in cart' do
      it 'returns 30' do
        expect(calculate_shipping_price).to eql 30
      end
    end

    context 'when max amount is less than 10' do
      before do
        product1.amount = 8
        product1.price = 1
        cart.products << product1
      end

      it 'returns 30' do
        expect(calculate_shipping_price).to eql 30
      end
    end

    context 'when subtotal price is bigger then 400' do
      before do
        product1.amount = 400
        product1.price = 2
        cart.products << product1
      end

      it 'returns 0' do
        expect(calculate_shipping_price).to eql 0
      end
    end

    context 'when have more then 10 kg in cart' do
      before do
        product1.amount = 15
        product1.price = 1
        cart.products << product1
      end

      it 'returns 37' do
        expect(calculate_shipping_price).to eql 37
      end
    end
  end
  describe '#aplly_coupon' do
    subject(:aplly_coupon) do
      cart_service.aplly_coupon(coupon_name)
    end
    context 'when is coupon A' do
      before do
        product1.amount = 10
        product1.price = 1
        cart.products << product1
        cart_service.calculations
      end
      it 'returns cart with discount' do
        expect(aplly_coupon.total_price).to eql 7.0
      end
    end

    context 'when is coupon FOO' do
      let(:coupon_name) { 'FOO' }

      before do
        product1.amount = 10
        product1.price = 1
        cart.products << product1
      end

      it 'returns cart with discount' do
        expect(aplly_coupon.total_price).to eql 0
      end
    end

    context 'when is coupon C' do
      let(:coupon_name) { 'C' }

      it 'returns cart with free shipping minimum price changed' do
        expect(aplly_coupon.free_shipping_limit).to eql 300.50
      end
    end
  end
end
