class Admin::ProductsController < AdminController
  
  before_filter :categories
  
  def index
    @products = Product.page(1)
  end
  
  def new
    @product = Product.new
    @brands = Brand.order(:name)
    @statuses = Status.all
  end
  
  def create
  end
  
  def edit
    @product = Product.find params[:id]
    @brands = Brand.order(:name)
    @statuses = Status.all
    @video = Video.new
  end
  
  def update
    @product = Product.find params[:id]
    @product.update_attributes(params[:product])
    if @product.save
      flash[:notice] = t('crud.successful_update')
      redirect_to admin_products_url
    else
      flash.now[:error] = t('crud.error')
      render :edit
    end
  end
  
  def destroy
  end
  
  
private
  
  def categories
    @categories = Category.all
  end
  
end
