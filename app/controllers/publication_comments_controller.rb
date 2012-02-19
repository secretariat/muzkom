class PublicationCommentsController < ShopController
  def create
    @comment = PublicationComment.new(params[:publication_comment])
    @comment.save
    redirect_to publication_path(Publication.find(params[:publication_id]))
  end
end