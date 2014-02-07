class Admin::BrandGroupsController < AdminController
  def index
  	@brand_group = BrandGroup.all
  end

  def show
    @brands = BrandGroup.find(params[:id]).brands
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
    @brand_group = BrandGroup.find(params[:id])
  end

  def update
    @brand_group = BrandGroup.find(params[:id])
    @brand_group.update_attributes(params[:brand_group])
    if @brand_group.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_brand_groups_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end

  def destroy
    BrandGroup.find(params[:id]).destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_brand_groups_url
  end

end
