# frozen_string_literal: true

class CartService
  FREE_SHIPPING_LIMIT = 400
  SIMPLE_SHIPPING_LIMIT = 10
  SIMPLE_SHIPPING_PRICE = 30
  EXCEEDED_AMOUNT_PRICE = 7
  EXCEEDED_AMOUNT_THRESHOLD = 5
  COUPON_A_PERCENTAGE = 0.3
  COUPON_FOO_DISCONT = 100
  COUPON_C_FREE_SHIPPING_LIMIT = 300.50

  attr_accessor :cart

  def initialize(cart_id)
    @cart = Cart.find(cart_id)
  end

  def calculate_sub_total_price
    subtotal_price = 0
    Product.where(cart_id: @cart.id).each do |product|
      subtotal_price += product.amount * product.price
    end
    subtotal_price
  end

  def calculate_max_amount
    Product.where(cart_id: @cart.id).maximum('amount') || 0
  end

  def calculate_shipping_price
    max_amount = calculate_max_amount || 0
    if calculate_sub_total_price >= @cart.free_shipping_limit
      shipping_price = 0
    elsif max_amount <= SIMPLE_SHIPPING_LIMIT
      shipping_price = 30
    else
      exceeded_amount = max_amount - SIMPLE_SHIPPING_LIMIT
      shipping_price_aditional = (exceeded_amount / EXCEEDED_AMOUNT_THRESHOLD)
      shipping_price_aditional *= EXCEEDED_AMOUNT_PRICE
      shipping_price = SIMPLE_SHIPPING_PRICE + shipping_price_aditional
    end
    shipping_price
  end

  def aplly_coupon(coupon_name)
    case coupon_name
    when 'A'
      @cart.total_price -= (@cart.subtotal_price * COUPON_A_PERCENTAGE)
    when 'FOO'
      @cart.total_price -= COUPON_FOO_DISCONT
      @cart.total_price = 0 if @cart.total_price.negative?
    when 'C'
      @cart.free_shipping_limit = COUPON_C_FREE_SHIPPING_LIMIT
      @cart.shipping_price = 0 if @cart.total_price >= @cart.free_shipping_limit
    end
    @cart.save
    @cart
  end

  def aplly_coupons
    Coupon.where(cart_id: @cart.id).each do |coupon|
      aplly_coupon(coupon.name)
    end
  end

  def calculations
    @cart.subtotal_price = @cart.total_price = calculate_sub_total_price
    @cart.shipping_price = calculate_shipping_price
    aplly_coupons
    @cart.save
    @cart
  end
end
