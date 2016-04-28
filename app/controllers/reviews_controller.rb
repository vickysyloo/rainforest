class ReviewsController < ApplicationController
  before_action :load_product
  before_action :ensure_logged_in, only: [:create, :destroy]

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to products_path, notice: "Review created successfully." }
        format.js{} # This will look for app/views/reviews/create.js.erb
      else
        format.html { render "products/show", alert: "Error!" }
        format.js{}
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
