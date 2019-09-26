class CartsService

  FREE_SHIPPING_LIMIT = 400
  SIMPLE_SHIPPING_LIMIT = 10
  SIMPLE_SHIPPING_PRICE = 30
  EXCEEDED_AMOUNT_PRICE = 7
  EXCEEDED_AMOUNT_THRESHOLD = 5
  COUPON_A_PERCENTAGE = 0.3
  COUPON_FOO_DISCONT = 100
  COUPON_C_FREE_SHIPPING_LIMIT = 300.50
  attr_acessor :cart

  def initialize(cart_id)
    @cart = Cart.find(cart_id)
  end

  def list_products
    Product.where(cart_id: @cart.id)
  end

  def list_coupons
    Coupon.where(cart_id: @cart.id)
  end

  def calculate_sub_total_price
    @cart.subtotal_price = Product.where(cart_id: @cart.id).sum('price')
  end

  def calculate_max_amount
    Product.where(cart_id: @cart.id).maximum('amount')
  end

  def calculate_shipping_price
    return @cart.shipping_price = 0 if @cart.subtotal_price >= FREE_SHIPPING_LIMIT

    max_amount = calculate_max_amount
    return @cart.shipping_price = 30 if max_amount <= SIMPLE_SHIPPING_LIMIT

    exceeded_amount = max_amount - SIMPLE_SHIPPING_LIMIT
    shipping_price_aditional = (exceeded_amount / EXCEEDED_AMOUNT_THRESHOLD)
    shipping_price_aditional *= EXCEEDED_AMOUNT_PRICE
    shipping_price = SIMPLE_SHIPPING_PRICE + shipping_price_aditional

    @cart.shipping_price = shipping_price
  end

  def aplly_coupons
    Coupon.where(cart_id: @cart.id, name: 'A').find_each do |coupon|
      @cart.total_price -= (@cart.subtotal_price * COUPON_A_PERCENTAGE)
    end

    Coupon.where(cart_id: @cart.id, name: 'FOO').find_each do |coupon|
      @cart.total_price -= @cart.subtotal_price - COUPON_FOO_DISCONT
    end

    coupon_c = Coupon.where(cart_id: @cart.id, name: 'C')
    if coupon_c
      if @cart.total_price >= COUPON_C_FREE_SHIPPING_LIMIT
        @cart.shipping_price = 0
      end
    end
  end
end