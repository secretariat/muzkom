class PublicationsController < ShopController
  
  def index
    @publications = Publication.by_date.page(params[:page])
  end
  
  def show
    @publication = Publication.find params[:id]
    @related = Publication.visible.where("id!=?", params[:id]).order("date DESC").limit(10)
    @comment = PublicationComment.new
  end
  
end