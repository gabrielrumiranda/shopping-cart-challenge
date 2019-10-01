# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :set_cart, only: %i[show update destroy]

  def index
    @carts = Cart.all
    render json: @carts
  end

  def create
    user_token = { user_token: request.headers['HTTP_USER_TOKEN'] }
    @cart = Cart.create!(user_token)

    if @cart.save
      render json: @cart, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: Cart.where(id: params[:id])
  end

  def update
    user_token = { user_token: request.headers['HTTP_USER_TOKEN'] }
    if @cart.update(user_token)
      render json: @cart, status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
  end

  def checkout
    cart_service = CartService.new(params[:cart_id])
    @cart = cart_service.calculations
    render json: {  total_price: @cart.total_price,
                    subtotal_price: @cart.subtotal_price,
                    shipping_price: @cart.shipping_price }
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
