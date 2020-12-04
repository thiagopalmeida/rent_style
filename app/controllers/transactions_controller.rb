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
    authorize @transaction
    if @transaction.save
      redirect_to @product, notice: 'transaction was successfully created.'
      @product.available = false
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payment_method)
  end

end
