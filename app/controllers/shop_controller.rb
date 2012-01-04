class ShopController < ApplicationController
  before_filter :load_catalog
  
  def load_catalog
    @categories = Category.visible_categories
  end
  
end
