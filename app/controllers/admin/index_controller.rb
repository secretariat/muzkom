class Admin::IndexController < AdminController
  
  def index
    @currency = Currency.find_by_brand_id 0
  end
  
end
