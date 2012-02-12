class PagesController < ShopController
  
  before_filter :latest_products
  
  def index
    @products = Product.limit(12).all
    @page = Page.find :first
    @slides = Slide.all
  end
  
  def show
    @page = Page.find_by_uri params[:uri]
  end
  
end
