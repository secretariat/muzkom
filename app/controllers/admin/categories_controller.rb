class Admin::CategoriesController < AdminController
  before_filter :categories_list, :only => [:index, :show]
  before_filter :find_category, :only => [:edit, :update, :show, :destroy, :visibility ]
  
  def index
  end
  
  def show
    render :index
  end
  
  def edit
  end
  
  def update
    @category.update_attributes(params[:category])
    if @category.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_categories_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
  def new
    @category = Category.new
  end
  
  def create
    last = Category.order("priority DESC").limit(1)
    params[:category][:priority] = last[0].priority+1
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = t('crud.successful_create')
      redirect_to admin_categories_url
    else
      flash[:error] = t('crud.error')
      render :action => :new
    end
  end
  
  def destroy
    @category.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_categories_url
  end
  
  def visibility
    @category.visibility = @category.visibility==false ? true : false
    if @category.save
      flash[:success] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
    redirect_to request.referer || admin_categories_url
  end
  
private 

  def find_category
    @category = Category.find params[:id]
  end
  
  def categories_list
    @categories = Category.all
  end
end
