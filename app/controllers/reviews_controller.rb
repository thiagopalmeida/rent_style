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
      redirect_to @product, notice: 'rating was successfully created.'
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
