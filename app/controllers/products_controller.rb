class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product

    if @product.save
      redirect_to root_path, notice: "Produto criado com sucesso!"
    else
      render :new
    end
  end

  def show
  end

  private

  def product_params
    params.require(:product).permit(:category, :subcategory, :brand, :size, :description, :price, :photos)
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
