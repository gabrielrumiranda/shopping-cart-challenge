# frozen_string_literal: true

class Api::ProductsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_product, only: %i[show update destroy]

  def index
    render json: @cart.products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.find_by(name: product_params['name'])

    if @product
      @product.amount += 1
    else
      @product = @cart.products.create!(product_params)
    end
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def set_cart_product
    @product = @cart.products.find_by!(id: params[:id]) if @cart
  end

  def product_params
    params.permit(:name, :price, :amount)
  end
end
