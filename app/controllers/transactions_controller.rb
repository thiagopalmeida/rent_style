class TransactionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @transaction = Transaction.new
    authorize @transaction
  end

  def create
    @product = Product.find(params[:product_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.product = @product
    @transaction.user = current_user
    @transaction.price = @product[:price]
    authorize @transaction
    if @transaction.save
      redirect_to my_products_products_path, notice: 'Aluguel realizado com sucesso.'
      @product.available = false
      @product.save
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payment_method, :available)
  end
end
