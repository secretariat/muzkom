class Admin::ProductsController < AdminController
  respond_to :html, :js
  before_filter :load_lists, :only => [:edit, :new]
  before_filter :find_product, :only => [:edit, :update, :destroy, :visibility, :show_index]
  
  def index
    unless session[:show_only_products].nil?
      where = session[:show_only_products]=="withdrawn" ? "AND status_id = 4" : "AND status_id != 4"
    else
      where = ""
    end
    unless params[:subcategory_id].nil?
      @products = Product.includes(:brand).order("brands.name").where("subcategory_id = ? #{where}", params[:subcategory_id]).page(params[:page]).per(100)
      @total = Product.where("subcategory_id = ? #{where}", params[:subcategory_id]).count
    else
      if params[:brand_id].nil?
        @products = Product.includes(:brand).where("1=1 #{where}").order("brands.name").page(params[:page]).per(100)
        @total = Product.where("1=1 #{where}").count
      else
        @products = Product.where("brand_id = ? #{where}", params[:brand_id]).order(:name).page(params[:page]).per(100)
        @total = Product.where("brand_id = ? #{where}", params[:brand_id]).count
      end
    end
    @categories = Category.all
    @brand = Brand.find params[:brand_id] unless  params[:brand_id].nil?
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = t('crud.successful_update')
      redirect_to list_url
    else
      flash.now[:error] = t('crud.error')
      load_lists
      render :new
    end
  end
  
  def edit
    @video = Video.new
    @photo = Photo.new
  end
  
  def update
    @product.update_attributes(params[:product])
    unless request.xhr?
      if @product.save
        flash[:notice] = t('crud.successful_update')
        redirect_to list_url
      else
        @categories = Category.all
        flash.now[:error] = t('crud.error')
        render :edit
      end
    else
      render :json => {:status => "ok"}
    end
  end
  
  def destroy
    @product.destroy
    flash[:notice] = t('crud.successful_destroy')
    redirect_to list_url
  end
  
  def visibility
    @product.visibility = @product.visibility == false ? true : false
    @product.save
    redirect_to list_url unless request.xhr?
  end
  
  def show_index
    @product.show_index = @product.show_index==false ? true : false
    @product.save
    redirect_to list_url unless request.xhr?
  end
  
  def switch
    unless params[:show].nil?
      session[:show_only_products] = params[:show]
    end
    redirect_to request.referer || admin_products_path
  end
  
  
private

  def list_url
    unless params[:subcategory_id].nil? 
      admin_subcategory_products_url(params[:subcategory_id])
    else
      return params[:brand_id].nil? ? admin_products_url : admin_brand_products_url(params[:brand_id])
  end
  end
  
  def find_product
    @product = Product.find params[:id]
  end
  
  def load_lists
    @brands = Brand.order(:name)
    @statuses = Status.all
    @categories = Category.all
    @promotions = Promotion.visible
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
    @brand = Brand.find params[:brand_id] unless  params[:brand_id].nil?
  end
end
