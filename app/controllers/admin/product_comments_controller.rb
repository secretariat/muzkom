# -*- encoding : utf-8 -*-
class Admin::ProductCommentsController < AdminController
  
  def index
    @comments = ProductComment.order("created_at DESC")
  end
  
  def destroy
    @comment = ProductComment.find params[:id]
    @comment.destroy
    redirect_to request.referer
  end
  
end
