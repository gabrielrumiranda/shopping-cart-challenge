# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products API' do
  let!(:cart) { create(:cart) }
  let!(:coupons) { create_list(:coupon, 10, cart_id: cart.id) }
  let(:cart_id) { cart.id }
  let(:id) { coupons.first.id }

  describe 'GET /api/carts/:cart_id/coupons' do
    before { get "/api/carts/#{cart_id}/coupons" }

    context 'when cart exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all cart coupons' do
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

  describe 'GET /api/carts/:cart_id/coupons/:id' do
    before { get "/api/carts/#{cart_id}/coupons/#{id}" }

    context 'when cart product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the coupon' do
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'when cart product does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Coupon/)
      end
    end
  end

  describe 'POST /api/carts/:cart_id/products' do
    let(:valid_attributes) { { name: 'Coupon A', coupon_type: 'PERCENTUAL_COUPON' } }

    context 'when request attributes are valid' do
      before { post "/api/carts/#{cart_id}/coupons", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/carts/#{cart_id}/coupons", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end

    context 'when coupon type is not acceptable' do
      before do 
        valid_attributes[:coupon_type] = 'INVALID TYPE'
        post "/api/carts/#{cart_id}/coupons", params: valid_attributes
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Coupon type INVALID TYPE is not a valid type/)
      end
    end
  end

  describe 'PUT api/carts/:cart_id/coupons/:id' do
    let(:valid_attributes) { { name: 'Coupon C' } }

    before { put "/api/carts/#{cart_id}/coupons/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the coupon' do
        updated_coupon = Coupon.find(id)
        expect(updated_coupon.name).to match(/Coupon C/)
      end
    end

    context 'when the coupon does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Coupon/)
      end
    end
  end

  describe 'DELETE api/carts/:id' do
    before { delete "/api/carts/#{cart_id}/coupons/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
