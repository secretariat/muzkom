class Admin::ProductCommentsController < AdminController
  
  def destroy
    @comment = ProductComment.find params[:id]
    @comment.destroy
    redirect_to request.referer
  end
  
end