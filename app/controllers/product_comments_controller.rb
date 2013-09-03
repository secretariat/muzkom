# -*- encoding : utf-8 -*-
class ProductCommentsController < ShopController
  def create
    @comment = ProductComment.new(params[:product_comment])
    if verify_recaptcha(:model=> @comment) && @comment.save
      redirect_to product_path(Product.find(params[:product_id]))
    else
      flash[:form_error] = "Не верно введена надпись на картинке"
      redirect_to request.referer
    end
  end
end
