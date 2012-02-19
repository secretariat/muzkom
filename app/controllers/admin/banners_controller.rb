class Admin::bannersController < AdminController
  before_filter :find_banner, :only => [:update, :edit, :destroy, :visibility]
  
  def index
    @banners = Banner.all
  end

  def new
    @banner = Banner.new
  end
  
  def create
     @banner = Banner.new(params[:banner])
     if @banner.save
       flash[:success] = t('crud.successful_create')
       redirect_to admin_banners_url
     else
       flash[:error] = t('crud.error')
       render :action => :new
     end
   end

  def edit
  end

  def update
    @banner.update_attributes(params[:banner])
    if @banner.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_banners_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
  def destroy
    @banner.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_banners_url
  end
  
  def visibility
    @banner.visibility = @banner.visibility==false ? true : false
    if @banner.save
      flash[:success] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
    redirect_to admin_banners_url
  end
  
  def upload
    @filename = params[:file].original_filename.gsub(' ', '_')
    File.open(banner_upload_root.join(@filename), 'wb') do |file|
      file.write(params[:file].read)
    end
  end
  
private
  def find_banner
    @banner = Banner.find params[:id]
  end

end
