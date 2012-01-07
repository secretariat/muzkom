class PagesController < ShopController
  
  def index
    @products = Product.limit(12).all
  end
  
  def show
    @page = Page.find_by_uri params[:uri]
  end
  
end
