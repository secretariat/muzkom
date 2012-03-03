class Admin::SubcategoriesController < AdminController
  
  before_filter :find_subcategory, :only => [:edit, :update, :show, :destroy, :visibility ]
  
  def new
    @subcategory = Subcategory.new
    @category = Category.find params[:category_id]
  end
  
  def create
    last = Subcategory.order("priority DESC").limit(1)
    params[:subcategory][:priority] = last[0].priority+1
    @subcategory = Subcategory.new(params[:subcategory])
    if @subcategory.save
      flash[:success] = t('crud.successful_create')
      redirect_to admin_category_url params[:category_id]
    else
      flash[:error] = t('crud.error')
      render :action => :new
    end
  end
  
  def edit
    @category = Category.find params[:category_id]
  end
  
  def update
    @subcategory.update_attributes(params[:subcategory])
    if @subcategory.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_category_url params[:category_id]
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
  def visibility
    @subcategory.visibility = vis = @subcategory.visibility==false ? true : false
    if @subcategory.save
      @subcategory.products.update_all("visibility = #{vis}")
    end
    redirect_to admin_category_url(params[:category_id]) unless request.xhr?
  end
  
  def destroy
    @subcategory.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_category_url(@subcategory.category)
  end
  
  def sort
    params[:subcategory].each_with_index do |id, index| 
      Subcategory.update_all({:priority => index+1}, {:id => id})
    end
    render :nothing => true
  end
  
  def move
    Subcategory.update_all({:category_id => params[:subcategory][:category_id]},{:id => params[:subcategory][:ids]})
    redirect_to request.referer
  end
  
private 

  def find_subcategory
    @subcategory = Subcategory.find params[:id]
  end
  
end