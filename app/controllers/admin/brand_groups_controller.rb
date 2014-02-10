# -*- encoding : utf-8 -*-
class Admin::BrandGroupsController < AdminController
  before_filter :check_if_null, :only=>[:enter, :change]

  def index
  	@brand_group = BrandGroup.order("name ASC")
    @default_group_size = Brand.where( :brand_group_id => [1,nil] ).size
  end

  def show
    if params[:id].to_i == 1
      @brands = Brand.where( :brand_group_id => [1,nil] )
    else
      @brands = BrandGroup.find(params[:id]).brands.order("name ASC")
    end
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
      group_update( @brand_group )
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

#################################################################################
#################################################################################
private
  def group_update( brand_group )
    brands = brand_group.brands
    brands.each do |brand|
      update_currency( brand, brand_group )
    end
  end

  def update_currency( brand, brand_group )
    @usd = brand_group.usd_to_uah
    @eur = brand_group.eur_to_uah
    calculate( @usd, @eur )
    ( brand.currencies.size == 0 ) ? create_coef( brand.id ) : update_coef( brand.id )
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

  def create_coef(brand_id)
    Currency.create({:coef=>@usd_to_uah, :brand_id => brand_id, :input=>"usd", :output=>"uah"})
    Currency.create({:coef=>@eur_to_uah, :brand_id => brand_id, :input=>"eur", :output=>"uah"})
    Currency.create({:coef=>@uah_to_usd, :brand_id => brand_id, :input=>"uah", :output=>"usd"})
    Currency.create({:coef=>@uah_to_eur, :brand_id => brand_id, :input=>"uah", :output=>"eur"})
    Currency.create({:coef=>@usd_to_eur, :brand_id => brand_id, :input=>"usd", :output=>"eur"})
    Currency.create({:coef=>@eur_to_usd, :brand_id => brand_id, :input=>"eur", :output=>"usd"})
  end
  # def check_if_null
  #   if params[:currency][:usd].to_f == 0.0 || params[:currency][:eur].to_f == 0.0
  #     flash[:error] = "Курс валюты не может ровняться 0.0"
  #     redirect_to redirect_url
  #   end
  # end

end
