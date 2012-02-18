class Admin::ProductsController < AdminController
  respond_to :html, :js
  before_filter :categories, :only => [:index, :edit, :new]
  before_filter :find_product, :only => [:edit, :update, :destroy, :visibility, :show_index]
  
  def index
    unless params[:subcategory_id].nil?
      @products = Product.where("subcategory_id = ?", params[:subcategory_id]).page(params[:page]).per(100)
      @total = Product.where("subcategory_id = ?", params[:subcategory_id]).count
    else
      @products = Product.page(params[:page]).per(100)
      @total = Product.count
    end
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
  end
  
  def new
    @product = Product.new
    @brands = Brand.order(:name)
    @statuses = Status.all
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
  end
  
  def create
    @product = Part.new(params[:part])
    if @product.save
      flash[:notice] = t('crud.successful_update')
      redirect_to list_url
    else
      flash.now[:error] = t('crud.error')
      # flash.now[:error] += ". "+@auto.errors.messages[:image][0] unless @auto.errors.messages[:image].nil?
      render :new
    end
  end
  
  def edit
    @brands = Brand.order(:name)
    @statuses = Status.all
    @video = Video.new
    @photo = Photo.new
    @promotions = Promotion.visible
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
  end
  
  def update
    @product.update_attributes(params[:product])
    unless request.xhr?
      if @product.save
        flash[:notice] = t('crud.successful_update')
        redirect_to list_url
      else
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
    redirect_to list_url
  end
  
  def show_index
    @product.show_index = @product.show_index==false ? true : false
    @product.save
    redirect_to list_url
  end
  
  
private

  def list_url
    params[:subcategory_id].nil? ? admin_products_url : admin_subcategory_products_url(params[:subcategory_id])
  end
  
  def categories
    @categories = Category.all
  end
  
  def find_product
    @product = Product.find params[:id]
  end
end
