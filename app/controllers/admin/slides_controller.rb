# -*- encoding : utf-8 -*-
class Admin::SlidesController < AdminController
  before_filter :find_slide, :only => [:update, :edit, :destroy, :visibility]
  
  def index
    @slides = Slide.all
  end

  def new
    @slide = Slide.new
  end
  
  def create
     @slide = Slide.new(params[:slide])
     if @slide.save
       flash[:success] = t('crud.successful_create')
       redirect_to admin_slides_url
     else
       flash[:error] = t('crud.error')
       render :action => :new
     end
   end

  def edit
  end

  def update
    @slide.update_attributes(params[:slide])
    if @slide.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_slides_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
  def destroy
    @slide.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_slides_url
  end
  
  def visibility
    @slide.visibility = @slide.visibility==false ? true : false
    if @slide.save
      flash[:success] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
    redirect_to admin_slides_url
  end
  
  def upload
    @filename = params[:file].original_filename.gsub(' ', '_')
    File.open(slide_upload_root.join(@filename), 'wb') do |file|
      file.write(params[:file].read)
    end
  end
  
private
  def find_slide
    @slide = Slide.find params[:id]
  end

end
