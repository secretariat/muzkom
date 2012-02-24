class Admin::BrandsController < AdminController
    before_filter :find_brand, :only => [:update, :edit, :destroy, :visibility]

    def index
      @brands = Brand.order(:name)
    end

    def new
      @brand = Brand.new
    end

    def create
      @brand = Brand.new(params[:brand])
      if @brand.save
        flash[:success] = t('crud.successful_create')
        redirect_to admin_brands_url
      else
        flash[:error] = t('crud.error')
        render :action => :new
      end
    end

    def edit
    end

    def update
      @brand.update_attributes(params[:brand])
      if @brand.save
        flash[:success] =  t('crud.successful_update')
        redirect_to admin_brands_url
      else
        flash[:error] = t('crud.error')
        render :edit
      end
    end

    def destroy
      @brand.destroy
      flash[:success] = t('crud.successful_destroy')
      redirect_to admin_brands_url
    end

    def visibility
      @brand.visibility = vis = @brand.visibility==false ? true : false
      if @brand.save
        @brand.products.update_all("visibility = #{vis}")
        flash[:success] = t('crud.successful_update')
      else
        flash[:error] = t('crud.error')
      end
      redirect_to admin_brands_url
    end
    
  private

    def find_brand
      @brand = Brand.find params[:id]
    end
  
end
