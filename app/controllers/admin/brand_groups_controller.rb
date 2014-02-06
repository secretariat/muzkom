class Admin::BrandGroupsController < AdminController
  def index
  	@brand_group = BrandGroup.all
  end

  def new
  	@brand_group = BrandGroup.new
  end

  def create
  	@brand_group = BrandGroup.new(params[:brand_group])
    if @brand_group.save
      flash[:success] = t('crud.successful_create')
      redirect_to admin_brand_groups_url
    else
      flash[:error] = t('crud.error')
      render :action => :new
    end
  end

  def edit
  end

  def destroy
    @brand_group.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_brand_groups_url
  end

end
