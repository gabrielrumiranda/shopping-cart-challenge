# frozen_string_literal: true

class Api::CouponsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_coupon, only: %i[show update destroy]

  def index
    render json: @cart.coupons
  end

  def show
    render json: @coupon
  end

  def create
    @coupon = @cart.coupons.create!(coupon_params)

    if @coupon.save
      render json: @coupon, status: :created
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  def update
    if @coupon.update(coupon_params)
      render json: @coupon, status: :ok
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @coupon.destroy
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def set_cart_coupon
    @coupon = @cart.coupons.find_by!(id: params[:id]) if @cart
  end

  def coupon_params
    params.permit(:name, :coupon_type)
  end
end
