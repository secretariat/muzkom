class Admin::IndexController < AdminController
  
  def index
    @currency = Currency.find_by_brand_id 0
    @product_comments = ProductComment.latest
  end
  
end
