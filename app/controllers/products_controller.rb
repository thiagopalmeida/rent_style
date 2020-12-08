class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_product, only: %i[show edit update destroy availability]

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product

    if @product.save
      redirect_to product_path(@product), notice: "Produto criado com sucesso!"
    else
      render :new
    end
  end

  def show
    @user = @product.user
    @marker = {
      lat: @user.latitude,
      lng: @user.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { user: @user }),
      image_url: helpers.asset_url('rentStyle.png')
    }
  end

  def index
    @products = policy_scope(Product).order(created_at: :desc)

    @users = User.all
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { user: user }),
        image_url: helpers.asset_url('rentStyle.png')
      }
    end
  end

  def my_products
    @products = policy_scope(Product).where(user_id: current_user.id)
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
    if @product.transactions == []
      @product.destroy
      redirect_to root_path, notice: 'Produto apagado com sucesso!'
    # Quando tiver a pagina com todos os produtos do usuario, redirecionar para ela.
    else
      @product.update(available: false)
      redirect_to root_path, notice: 'Não é possível apagar o produto, pois há transação registrada envolvendo-o.
      O produto foi marcado como indisponível.'
    end
  end

  def pause
    @product = Product.find(params[:product_id])
    authorize @product
    @product.toggle!(:available)
    redirect_to product_path(@product)
  end

  private

  def product_params
    params.require(:product).permit(:category, :subcategory, :brand, :size, :description, :price, :available, photos: [])
  end

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def available?
    @product = Product.find(params[:id])
    authorize @product
    @product.available
  end
end
