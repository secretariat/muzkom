# -*- encoding : utf-8 -*-
class CartController < ShopController
  
  before_filter :get_product, :only => [:add, :delete]
  
  def index
    @banners_left = Placement.find(7).banners.order(:position)
    @banners_right = Placement.find(8).banners.order(:position)
  end
  
  def add
    unless @product.withdrawn?
      quantity = params[:quantity] || 1
      @item = @cart.add_product(@product, quantity) 
    end
    redirect_to cart_path
  end
  
  def delete
    @cart.delete_product(@product)
    session[:cart] = @cart
    cart_redirect t("flash.delete_product", :product => @product.title)
  end
  
  def empty
    session[:cart] = nil
    @cart.items = []
    render :action => "add", :layout=>false
  end
  
  def change
    @item = @cart.items.find{|item| item.product.id == params[:cart_item][:product_id].to_i}
    @item.update_quantity(params[:cart_item][:quantity])
    redirect_to cart_path
  end
  
private 

  def get_product
    begin
      @product = Product.find params[:id]
    rescue ActiveRecord::RecordNotFound
      logger.error("Attemp to access invalid product #{params[:id]}")
      cart_redirect t("flash.product_not_found")
    end
  end
  
  def cart_redirect(msg)
    flash[:notice] = msg
    redirect_to :action => :index
  end
  
end
