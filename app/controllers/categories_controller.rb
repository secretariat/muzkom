# -*- encoding : utf-8 -*-
class CategoriesController < ShopController

  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  CURRENCIES = {:usd=>"USD", :uah=>"грн", :eur=>"EUR"}

  before_filter :latest_products

  def show
    # @currency = CURRENCIES[:"#{session[:currency]}"]
    @order_by = order_by
    @subcategory = Subcategory.visible.find params[:id]
    if order_by == "price"
      @products = Product.by_subcategory(@subcategory).includes(:status).order_by_price.page(params[:page])
      # @products = sort_price_withfix(@products)
      # @products.sort_by!{|p| p.price}
    else
      @products = Product.by_subcategory(@subcategory).includes(:status).order(:"#{@order_by}").page(params[:page])
      # @products = sort_price_withfix(@products)
    end

    @current_category = @subcategory
    @brands = Product.by_subcategory(@subcategory).includes(:brand).collect{|product| product.brand}.uniq
    @brands.sort!{|a, b| a.name.downcase <=> b.name.downcase}
    @banners_left = Placement.find(3).banners.order(:position)
    @banners_right = Placement.find(4).banners.order(:position)
  end

end
