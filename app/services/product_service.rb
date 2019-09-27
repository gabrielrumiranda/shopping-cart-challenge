class ProductService
  class << self

    def create(product_params, cart_id)
      product = Product.find_by(name: product_params[:name], cart_id: cart_id)
      cart = Cart.find_by(id: cart_id)
      if product
        product.amount += product_params[:amount].to_i
      else
        product = cart.products.create!(product_params)
      end
      product
    end

    def update_cart_prices(product)
      cart_service = CartService.new(product.cart_id)
      cart_service.calculations
    end
  end
end
