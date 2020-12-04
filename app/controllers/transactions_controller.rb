class TransactionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @transaction = Transaction.new
  end

  def create
    @product = Product.find(params[:product_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.product = @product
    if @transaction.save
      redirect_to @product, notice: 'transaction was successfully created.'
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payment_method)
  end

end
