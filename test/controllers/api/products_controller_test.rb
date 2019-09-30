# frozen_string_literal: true

require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test 'should get index' do
    get api_products_url, as: :json
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post api_products_url, params: { product: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show product' do
    get api_product_url(@product), as: :json
    assert_response :success
  end

  test 'should update product' do
    patch api_product_url(@product), params: { product: {} }, as: :json
    assert_response 200
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete api_product_url(@product), as: :json
    end

    assert_response 204
  end
end
