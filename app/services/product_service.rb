class ProductService

  def create(product_params)
    @product = Product.find_by(name: product_params[:name])

    if @product
      @product.amount += product_params[:amount].to_i
    else
      @product = @cart.products.create!(product_params)
    end

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
end
