# -*- encoding : utf-8 -*-
class BrandsController < ShopController

  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  before_filter :latest_products

  def show
    # @brand = Brand.visible.find params[:id]
    @brand = Brand.visible.find([52,72,3])
    @order_by = order_by
    @products = nil
    unless params[:category_id].nil?
      @subcategory = @brand.first.subcategories.find(params[:category_id])
      @brands = Product.by_subcategory(@subcategory).includes(:brand).collect{|product| product.brand}.uniq
      if order_by == "price"
        @brand.each do |brand|
          if @products.nil?
            @products = brand.products.by_subcategory(@subcategory).order_by_price.page(params[:page])
            puts @products.to_a.size
            # sleep(3)
          else
            @products += brand.products.by_subcategory(@subcategory).order_by_price.page(params[:page])
            puts @products.to_a.size
            # sleep(3)
          end
        end
        @products = Kaminari.paginate_array(@products).page(params[:page])
        # @products = Product.by_subcategory(@subcategory).includes(:status).order_by_price
        # @products = sort_price_withfix(@products)
        # @products.sort!{|p, p1| p.sale_price <=> p1.sale_price}
        # @products = revert_price( @products )
        # @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
      else
        @products =  @brand.products.by_subcategory(@subcategory).order(:"#{@order_by}").page(params[:page])
      end
      @current_category = @subcategory.category
      render 'categories/show'
    else
      @brand = Brand.visible.find params[:id]
      if order_by == "price"
        @products = @brand.products.visible.on_sale.order(:"#{@order_by}")
        @products = sort_price_withfix(@products)
        @products.sort!{|p, p1| p.sale_price <=> p1.sale_price}
        @products = revert_price( @products )
        @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
      else
        @products = @brand.products.visible.on_sale.order(:"#{@order_by}").page(params[:page])
      end
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
