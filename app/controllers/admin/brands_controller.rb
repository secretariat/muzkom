# -*- encoding : utf-8 -*-
class Admin::BrandsController < AdminController
  before_filter :find_brand, :only => [:update, :edit, :destroy, :visibility]

  def index
    @brands = Brand.order(:name)
  end

  def new
    @brand = Brand.new
    @brand_groups = BrandGroup.all
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
    @brand_groups = BrandGroup.all
  end

  def update
    @brand.update_attributes(params[:brand])
    # if( params[:brand][:brand_group_id].to_i != 1 )
    #   puts params[:brand][:brand_group_id]
    #   sleep(10)
      update_currency( @brand, params[:brand][:brand_group_id] )
    # end
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
    end
    redirect_to admin_brands_url unless request.xhr?
  end

  private

  def update_currency( brand, current_group_id )
    @brand_group = BrandGroup.find( current_group_id )
    @usd = @brand_group.usd_to_uah
    @eur = @brand_group.eur_to_uah
    calculate( @usd, @eur )
    update_coef brand.id
  end

  def calculate( usd, eur )
    @usd_to_uah = usd.to_f
    @eur_to_uah = eur.to_f
    @uah_to_usd = 1/usd.to_f
    @uah_to_eur = 1/eur.to_f
    @usd_to_eur = usd.to_f/eur.to_f
    @eur_to_usd = eur.to_f/usd.to_f
  end

  def update_coef(brand_id)
    Currency.update_all({:coef=>@usd_to_uah},{:brand_id=>brand_id, :input=>"usd", :output=>"uah"})
    Currency.update_all({:coef=>@eur_to_uah},{:brand_id=>brand_id, :input=>"eur", :output=>"uah"})
    Currency.update_all({:coef=>@uah_to_usd},{:brand_id=>brand_id, :input=>"uah", :output=>"usd"})
    Currency.update_all({:coef=>@uah_to_eur},{:brand_id=>brand_id, :input=>"uah", :output=>"eur"})
    Currency.update_all({:coef=>@usd_to_eur},{:brand_id=>brand_id, :input=>"usd", :output=>"eur"})
    Currency.update_all({:coef=>@eur_to_usd},{:brand_id=>brand_id, :input=>"eur", :output=>"usd"})
  end


  def find_brand
    @brand = Brand.find params[:id]
  end
end
