# -*- encoding : utf-8 -*-
class Admin::PublicationCommentsController < AdminController
  
  def index
     @comments = PublicationComment.order("created_at DESC")
  end
  
  def destroy
    @comment = PublicationComment.find params[:id]
    @comment.destroy
    redirect_to request.referer
  end
  
end
