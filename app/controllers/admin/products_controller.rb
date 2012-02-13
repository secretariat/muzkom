class Admin::ProductsController < AdminController
  
  before_filter :categories, :only => [:index, :edit, :new]
  before_filter :find_product, :only => [:edit, :update, :destroy, :visibility]
  
  def index
    unless params[:subcategory_id].nil?
      @products = Product.where("subcategory_id = ?", params[:subcategory_id]).page(1).per(100)
      @total = Product.where("subcategory_id = ?", params[:subcategory_id]).count
    else
      @products = Product.page(1).per(100)
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
    @subcategory = Subcategory.find params[:subcategory_id] unless  params[:subcategory_id].nil?
  end
  
  def update
    @product.update_attributes(params[:product])
    if @product.save
      flash[:notice] = t('crud.successful_update')
      redirect_to list_url
    else
      flash.now[:error] = t('crud.error')
      render :edit
    end
  end
  
  def destroy
    @product.destroy
    flash[:notice] = t('crud.successful_destroy')
    redirect_to list_url
  end
  
  def visibility
    @product.visibility = @product.visibility==false ? true : false
    if @product.save
      flash[:notice] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
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
