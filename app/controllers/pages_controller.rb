# -*- encoding : utf-8 -*-
class PagesController < ShopController
  
  before_filter :latest_products
  
  def index
    @products = Product.for_index
    @page = Page.find :first
    @slides = Slide.all
    @banners_left = Placement.find(1).banners.order(:position)
    @banners_right = Placement.find(2).banners.order(:position)
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
  
  def feed
    @publications = Publication.visible.order("date DESC").limit(10)
    respond_to do |format|
      format.rss { render :layout => false } #index.rss.builder
    end
  end
end
