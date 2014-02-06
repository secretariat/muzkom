# -*- encoding : utf-8 -*-
#encoding: utf-8
class Admin::CurrenciesController < AdminController

  before_filter :check_if_null, :only=>[:enter, :change]

  def index
  end

  def enter
    calculate params[:currency]
    brand_id = params[:brand_id].to_i
    unless Currency.where(:brand_id=>brand_id).blank?
      update_coef brand_id
    else
      Currency.create({:coef=>@usd_to_uah, :brand_id => brand_id, :input=>"usd", :output=>"uah"})
      Currency.create({:coef=>@eur_to_uah, :brand_id => brand_id, :input=>"eur", :output=>"uah"})
      Currency.create({:coef=>@uah_to_usd, :brand_id => brand_id, :input=>"uah", :output=>"usd"})
      Currency.create({:coef=>@uah_to_eur, :brand_id => brand_id, :input=>"uah", :output=>"eur"})
      Currency.create({:coef=>@usd_to_eur, :brand_id => brand_id, :input=>"usd", :output=>"eur"})
      Currency.create({:coef=>@eur_to_usd, :brand_id => brand_id, :input=>"eur", :output=>"usd"})
    end
    redirect_to redirect_url
  end

  def change
    calculate params[:currency]
    update_coef 0
    redirect_to redirect_url
  end

private

  def check_if_null
    if params[:currency][:usd].to_f == 0.0 || params[:currency][:eur].to_f == 0.0
      flash[:error] = "Курс валюты не может ровняться 0.0"
      redirect_to redirect_url
    end
  end

  def calculate(data)
    @usd_to_uah = data[:usd].to_f
    @eur_to_uah = data[:eur].to_f
    @uah_to_usd = 1/data[:usd].to_f
    @uah_to_eur = 1/data[:eur].to_f
    @usd_to_eur = data[:usd].to_f/data[:eur].to_f
    @eur_to_usd = data[:eur].to_f/data[:usd].to_f
  end

  def update_coef(brand_id)
    Currency.update_all({:coef=>@usd_to_uah},{:brand_id=>brand_id, :input=>"usd", :output=>"uah"})
    Currency.update_all({:coef=>@eur_to_uah},{:brand_id=>brand_id, :input=>"eur", :output=>"uah"})
    Currency.update_all({:coef=>@uah_to_usd},{:brand_id=>brand_id, :input=>"uah", :output=>"usd"})
    Currency.update_all({:coef=>@uah_to_eur},{:brand_id=>brand_id, :input=>"uah", :output=>"eur"})
    Currency.update_all({:coef=>@usd_to_eur},{:brand_id=>brand_id, :input=>"usd", :output=>"eur"})
    Currency.update_all({:coef=>@eur_to_usd},{:brand_id=>brand_id, :input=>"eur", :output=>"usd"})
  end

  def redirect_url
    unless params[:brand_id].nil?
      edit_admin_brand_url params[:brand_id]
    else
      admin_root_url
    end
  end

end
