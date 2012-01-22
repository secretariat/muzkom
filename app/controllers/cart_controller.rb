# encoding: utf-8
class CartController < ShopController
  
  before_filter :get_product, :only => [:add, :delete]
  
  def index
  end
  
  def add
    unless @product.withdrawn?
      quantity = params[:quantity] || 1
      @item = @cart.add_product(@product, quantity) 
    end
    redirect_to request.env["HTTP_REFERER"]
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