# -*- encoding : utf-8 -*-
class Admin::PromotionsController < AdminController
  before_filter :find_promotion, :only => [:update, :edit, :destroy, :visibility]
  
  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end
  
  def create
     @promotion = Promotion.new(params[:promotion])
     if @promotion.save
       flash[:success] = t('crud.successful_create')
       redirect_to admin_promotions_url
     else
       flash[:error] = t('crud.error')
       render :action => :new
     end
   end

  def edit
  end

  def update
    @promotion.update_attributes(params[:promotion])
    if @promotion.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_promotions_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
  def destroy
    @promotion.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_promotions_url
  end
  
  def visibility
    @promotion.visibility = @promotion.visibility==false ? true : false
    if @promotion.save
      flash[:success] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
    redirect_to admin_promotions_url
  end
  
  def upload
    @filename = params[:file].original_filename.gsub(' ', '_')
    File.open(promotion_upload_root.join(@filename), 'wb') do |file|
      file.write(params[:file].read)
    end
  end
  
private
  def find_promotion
    @promotion = Promotion.find params[:id]
  end

end
