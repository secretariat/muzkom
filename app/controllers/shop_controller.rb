class ShopController < ApplicationController
 
  before_filter :load_catalog
  before_filter :get_store_data    

  private
  
    def load_catalog
      @categories = Category.visible.includes(:subcategories).where(:subcategories=>{:visibility=>true})
      @brands = Brand.alphabetical
    end
  
    def get_store_data
      @cart = find_cart
      session[:currency] = "uah" if session[:currency].nil?
    end

    def find_cart
      session[:cart] ||= Cart.new
    end
  
    def latest_products
      @latest_products = Product.latest
    end
    
end
