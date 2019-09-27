
require 'rails_helper'

RSpec.describe 'Products Service' do
  let(:cart) { create(:cart) }
  let(:cart_id) { cart.id }
  let(:product_params) { { name: 'Banana', price: 30, amount: 20 } }

  describe '.create' do
    subject(:create_product) { ProductService.create(product_params, cart_id) }

    context 'when request attributes are valid' do

      it 'returns a valid product object' do
        expect(create_product).to be_valid
      end
    end
  end
end
