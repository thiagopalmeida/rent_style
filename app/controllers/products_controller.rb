class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_product, only: %i[show edit update destroy]

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

  def index
    @products = policy_scope(Product).order(created_at: :desc)
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path, notice: 'Produto apagado com sucesso!'
    # Depois redirecionar para a página com todos os produtos do usuário.
  end

  private

  def product_params
    params.require(:product).permit(:category, :subcategory, :brand, :size, :description, :price, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end
end
