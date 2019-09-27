class Api::CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]

  def index
    @carts = Cart.all
    # @carts = Cart.left_joins(:products).select('products.*').group_by(&:cart_id)
    # @carts = Product.joins(:cart).select('products.*').group_by(&:cart_id).all
    # puts @carts.products
    render json: @carts
  end

  def create
    @cart = Cart.create!(cart_params)

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
    if @cart.update(cart_params)
      render json: @cart, status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
  end

  private

  def cart_params
    params.permit(:user_token)
  end

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
