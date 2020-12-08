class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
    authorize @review
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to @product, notice: 'Obrigado pela sua avaliação.'
    else
      flash[:alert] = "Algo deu errado."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
