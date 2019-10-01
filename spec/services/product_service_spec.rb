# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products Service' do
  let(:cart) { create(:cart) }
  let(:cart_id) { cart.id }
  let(:product_params) { { name: 'Banana', price: 30, amount: 20 } }
  let(:product) { create(:product, cart_id: cart.id) }

  describe '.create' do
    subject(:create_product) { ProductService.create(product_params, cart_id) }

    context 'when request attributes are valid' do
      context 'when not have a product with requested name' do
        it 'returns a valid product object' do
          expect(create_product).to be_valid
        end
      end

      context 'when have a product with requested name' do
        before { product_params[:name] = product.name }

        it 'returns valid product' do
          expect(create_product).to be_valid
        end

        it 'amount equal the old amount plus the requested product amount' do
          product_amount = product_params[:amount] + product.amount
          expect(create_product.amount).to eql(product_amount)
        end
      end
    end

    context 'when request attributes are invalid' do
      before { product_params[:name] = '' }
      it 'returns invalid product' do
        create_product.save
        expect(create_product).to be_invalid
      end
      it 'has a error message' do
        create_product.save
        expect(create_product.errors.messages[:name]).to match(["can't be blank"])
      end
    end
  end
<<<<<<< HEAD

  describe '.update_cart_prices' do
    subject(:update_cart_prices) { ProductService.update_cart_prices(product) }

    context 'when cart is empty' do
      before do
        product.price = 1
        product_amount = 5
        cart.products << product
      end 
      it 'returns a cart with prices updates' do
        expect(update_cart_prices.subtotal_price).to eql (product.price * product.amount)
      end
      it 'returns shipping prices equals the minimum shipping price' do
        expect(update_cart_prices.shipping_price).to eql 30
      end
    end
  end
=======
>>>>>>> develop
end
