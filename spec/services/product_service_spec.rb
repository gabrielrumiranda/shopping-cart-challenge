
require 'rails_helper'

RSpec.describe 'Products Service' do
  let(:cart) { create(:cart) }
  let(:cart_id) { cart.id }
  let(:product_params) { { name: 'Banana', price: 30, amount: 20 } }
  let(:product) { ProductService.create({ name: 'Pera', price: 30, amount: 20 } , cart_id) }

  describe '.create' do
    subject(:create_product) { ProductService.create(product_params, cart_id) }

    context 'when request attributes are valid' do
      context 'when not have a product with requested name' do
        it 'returns a valid product object' do
          expect(create_product).to be_valid
        end
      end

      context 'when have a product with requested name' do
        before do
          product_params[:name] = product.name
        end

        it 'returns valid product' do
          expect(create_product).to be_valid
        end

        it 'amount equal the old amount plus the requested product amount' do
          product_amount = product_params[:amount] + product.amount

          expect(create_product.amount).to eql(product_amount)
        end
      end
    end
  end
end
