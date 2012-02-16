class ProductCommentsController < ShopController
  def create
    @comment = ProductComment.new(params[:product_comment])
    @comment.save
    redirect_to product_path(Product.find(params[:product_id]))
  end
end