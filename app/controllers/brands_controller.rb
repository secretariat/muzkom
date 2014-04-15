# -*- encoding : utf-8 -*-
class BrandsController < ShopController

  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  before_filter :latest_products

  def show
    if params[:delete] && !session[:brands].nil?
      session[:brands].delete(params[:id].to_i)
      if session[:brands].size == 0
        redirect_to category_path(params[:category_id]) and return
      end
    else
      if session[:brands].nil?
        session[:brands] = [params[:id].to_i]
      else
        session[:brands] << params[:id].to_i unless session[:brands].include?( params[:id].to_i )
      end
    end
    # @brand = Brand.visible.find params[:id]
    @brand = Brand.visible.find( session[:brands] )
    @order_by = order_by
    @products = nil
    unless params[:category_id].nil?
      @subcategory = @brand.first.subcategories.find( params[:category_id] )
      @brands = Product.by_subcategory(@subcategory).includes(:brand).collect{|product| product.brand}.uniq
      if order_by == "price"
        @products = get_products_from_brands( @brand, @subcategory, order_by )
        @products = sort_price_withfix(@products)
        @products.sort!{|p, p1| p.sale_price <=> p1.sale_price}
        @products = revert_price( @products )
        @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
      else
        # @products =  @brand.products.by_subcategory(@subcategory).order(:"#{@order_by}").page(params[:page])
        @products = get_products_from_brands( @brand, @subcategory, order_by )
        if order_by == "name"
          @products.sort!{|p, p1| p.name <=> p1.name}
        else
          @products.sort!{|p, p1| p.updated_at <=> p1.updated_at}
        end
        @products = Kaminari.paginate_array(@products).page(params[:page]).per(10)
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
        @products = @brand.products.visible.on_sale.order(:"#{@order_by}").page(params[:page]).per(10)
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

  def delete_brands_from_filter
    session[:brands].delete(params[:id].to_i)
  end

end
