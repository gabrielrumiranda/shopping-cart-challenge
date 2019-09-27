# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products API' do
  let!(:cart) { create(:cart) }
  let!(:products) { create_list(:product, 10, cart_id: cart.id) }
  let(:cart_id) { cart.id }
  let(:id) { products.first.id }

  describe 'GET /api/carts/:cart_id/products' do
    before { get "/api/carts/#{cart_id}/products" }

    context 'when cart exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all cart products' do
        expect(JSON.parse(response.body).size).to eq(10)
      end
    end

    context 'when cart does not exist' do
      let(:cart_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cart/)
      end
    end
  end

  describe 'GET /api/carts/:cart_id/products/:id' do
    before { get "/api/carts/#{cart_id}/products/#{id}" }

    context 'when cart product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the product' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when cart product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  describe 'POST /api/carts/:cart_id/products' do
    let(:valid_attributes) { { name: 'Banana', price: 30, shipping_price: 10.2, amount: 20 } }

    context 'when request attributes are valid' do
      context 'when not have a product with requested name' do
        before { post "/api/carts/#{cart_id}/products", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when have a product with requested name' do
        before do
          valid_attributes[:name] = products.first.name
          post "/api/carts/#{cart_id}/products", params: valid_attributes
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'amount equal the old amount plus the requested product amount' do
          product_amount = JSON.parse(response.body)['amount']
          expect_amount = valid_attributes[:amount] + products.first.amount

          expect(product_amount).to eql(expect_amount)
        end
      end
    end

    context 'when an invalid request' do
      before { post "/api/carts/#{cart_id}/products", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT api/carts/:cart_id/products/:id' do
    let(:valid_attributes) { { name: 'Apple' } }

    before { put "/api/carts/#{cart_id}/products/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the product' do
        updated_product = Product.find(id)
        expect(updated_product.name).to match(/Apple/)
      end
    end

    context 'when the product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  describe 'DELETE api/carts/:id' do
    before { delete "/api/carts/#{cart_id}/products/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
