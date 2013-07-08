# -*- encoding : utf-8 -*-
class ProductsController < ShopController

  before_filter :latest_products
  autocomplete :product, :name, :full => true, :display_value => :display_autocomplete, :extra_data => [:price, :image]

  def withdrawn
    @products = Product.withdrawn.where("brand_id = ?", params[:brand]).page(params[:page])
    @brand = Brand.find params[:brand]
  end

  def show
    @product = Product.visible.find(params[:id])
    @similar = Product.similar(@product)
    @current_category = @product.subcategory
    @comment = ProductComment.new
    @title_text = Text.find 8
    @banners_left = Placement.find(5).banners.order(:position)
    @banners_right = Placement.find(6).banners.order(:position)
  end

  def find_by_code
    @item = Product.where( :id => params[:search], :visibility => true ).first
    if !@item.blank?
      redirect_to product_path (@item.id)
    else
      flash[:notice] = "Товар с кодом #{params[:search]} не найден."
      redirect_to request.referer
    end
  end

  def search
    @prods = Product.where( "name LIKE ?", "%#{params[:term]}%" )
    # @prods = Products.search( params[:search] )
    respond_to do |format|
      format.json { render :json => @prods }
    end
  end

  def fullsearch
    @products = Product.search(params[:search])
    @page = Page.find :first
    @slides = Slide.all
    @banners_left = Placement.find(1).banners.order(:position)
    @banners_right = Placement.find(2).banners.order(:position)
  end

end
