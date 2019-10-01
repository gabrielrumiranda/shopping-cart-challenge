# frozen_string_literal: true

class ProductService
  class << self
    def create(product_params, cart_id)
      product = Product.where(name: product_params[:name], cart_id: cart_id).first_or_initialize.tap do |prod|
        if prod.new_record?
          prod.name = product_params[:name]
          prod.price = product_params[:price]
          prod.amount = product_params[:amount]
        else
          prod.amount += product_params[:amount].to_i
        end
      end
      product
    end
  end
end
