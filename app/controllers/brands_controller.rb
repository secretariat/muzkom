# -*- encoding : utf-8 -*-
class BrandsController < ShopController

  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  before_filter :latest_products

  def show
    @brand = Brand.visible.find params[:id]
    @order_by = order_by
    unless params[:category_id].nil?
      @subcategory = @brand.subcategories.find(params[:category_id])
      if order_by == "price"
        # @products =  @brand.products.by_subcategory(@subcategory).order_by_price.page(params[:page])
        @products = Product.by_subcategory(@subcategory).includes(:status).order_by_price
        @products = sort_price_withfix(@products)
        @products.sort!{|p, p1| p.sale_price <=> p1.sale_price}
        @products = revert_price( @products )
        @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
      else
        @products =  @brand.products.by_subcategory(@subcategory).order(:"#{@order_by}").page(params[:page])
      end
      @current_category = @subcategory.category
      render 'categories/show'
    else
      @products = @brand.products.visible.on_sale.order(:"#{@order_by}").page(params[:page])
    end
  end

  def withdrawn
    @products = Product.withdrawn.page(params[:page])
    @brand_list = Product.withdrawn.collect{|product| product.brand}.uniq
    @brand_list.sort!{|a, b| a.name.downcase <=> b.name.downcase}
  end

  # def range
  #   @brand = Brand.visible.find 76
  #   # @brand = Brand.visible.find params[:id]
  #   if(params[:from] && params[:to])
  #     @subcategory = @brand.subcategories.find(params[:category_id])
  #     @products = @brand.products.by_subcategory(@subcategory).where('price >= ? AND price <= ?', params[:from], params[:to] ).page(params[:page])
  #     render 'categories/show'
  #   end
  # end

end
