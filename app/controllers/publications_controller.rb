class PublicationsController < ShopController
  
  def index
    @publications = Publication.by_date.page(params[:page])
  end
  
  def show
  end
  
end