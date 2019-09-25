# frozen_string_literal: true

class Api::CouponsController < ApplicationController
  before_action :set_coupon, only: %i[show update destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    render json: Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    render json: @coupon
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    if @coupon.update(coupon_params)
      render json: @coupon, status: :ok, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def coupon_params
    params.permit(:name, :type)
  end
end
