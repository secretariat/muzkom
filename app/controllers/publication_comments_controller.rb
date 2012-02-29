#encoding: utf-8
class PublicationCommentsController < ShopController
  def create
    @comment = PublicationComment.new(params[:publication_comment])
    if verify_recaptcha(:model=> @comment) && @comment.save
      redirect_to publication_path(Publication.find(params[:publication_id]))
    else
      flash[:form_error] = "Не верно введена надпись на картинке"
      redirect_to request.referer
    end
  end
end