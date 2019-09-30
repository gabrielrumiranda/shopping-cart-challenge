# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts API' do
  let!(:carts) { create_list(:cart, 10) }
  let(:cart_id) { carts.first.id }

  describe 'GET /api/carts/' do
    before { get '/api/carts/' }

    context 'when carts exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all carts' do
        expect(JSON.parse(response.body).size).to eq(10)
      end
    end
  end

  describe 'GET /api/carts/:cart_id/' do
    before { get "/api/carts/#{cart_id}/" }

    context 'when cart exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the cart' do
        expect(JSON.parse(response.body)[0]['id']).to eq(cart_id.to_i)
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

  describe 'POST /api/carts/' do
    let(:valid_attributes) { { user_token: '12313112'} }

    context 'when request attributes are valid' do
        before { post "/api/carts/", params: valid_attributes }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

    context 'when an invalid request' do
      before { post "/api/carts/", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT api/carts/:cart_id/' do
    let(:valid_attributes) { { user_token: '12312' } }

    before { put "/api/carts/#{cart_id}/", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the cart' do
        updated_cart = Cart.find(cart_id)
        expect(updated_cart.user_token).to match(/12312/)
      end
    end

    context 'when the cart does not exist' do
      let(:cart_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cart/)
      end
    end
  end

  describe 'DELETE api/carts/:id' do
    before { delete "/api/carts/#{cart_id}/" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
