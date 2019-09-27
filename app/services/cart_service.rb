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

  def list_products
    Product.where(cart_id: @cart.id)
  end

  def list_coupons
    Coupon.where(cart_id: @cart.id)
  end

  def calculate_sub_total_price
    @cart.subtotal_price = 0
    Product.where(cart_id: @cart.id).each do |product| 
      @cart.subtotal_price += product.amount * product.price
    end
    @cart.total_price = @cart.subtotal_price
    @cart.save
  end

  def calculate_max_amount
    Product.where(cart_id: @cart.id).maximum('amount')
  end

  def calculate_shipping_price
    return @cart.shipping_price = 0 if @cart.subtotal_price >= @cart.free_shipping_limit

    max_amount = calculate_max_amount || 0
    return @cart.shipping_price = 30 if max_amount <= SIMPLE_SHIPPING_LIMIT

    exceeded_amount = max_amount - SIMPLE_SHIPPING_LIMIT
    shipping_price_aditional = (exceeded_amount / EXCEEDED_AMOUNT_THRESHOLD)
    shipping_price_aditional *= EXCEEDED_AMOUNT_PRICE
    shipping_price = SIMPLE_SHIPPING_PRICE + shipping_price_aditional
    @cart.shipping_price = shipping_price

    @cart.save
  end

  def aplly_coupon (coupon_name)
    case coupon_name
    when 'A'
      @cart.total_price -= (@cart.subtotal_price * COUPON_A_PERCENTAGE)
    when 'Foo'
      @cart.total_price -= COUPON_FOO_DISCONT
      @cart.total_price = 0 if @cart.total_price < 0
    when 'C'
      @cart.free_shipping_limit = COUPON_C_FREE_SHIPPING_LIMIT
      @cart.shipping_price = 0 if @cart.total_price >= @cart.free_shipping_limit
    end
    @cart.save
  end

  def aplly_coupons
    Coupon.where(cart_id: @cart.id).each do |coupon|
      aplly_coupon(coupon.name)
    end
  end

  def calculations
    calculate_sub_total_price
    calculate_shipping_price
    aplly_coupons
    @cart
  end
end
