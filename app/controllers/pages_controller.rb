class PagesController < ShopController
  
  before_filter :latest_products
  
  def index
    @products = Product.for_index
    @page = Page.find :first
    @slides = Slide.all
  end
  
  def show
    @page = Page.find_by_uri params[:uri]
  end
  
  def delivery
    @page = Page.find 4
    @kiev = Text.find 1
    @ukraine = Text.find 2
    @foreign = Text.find 3
    @how_to = Text.find 4
  end
  
end
