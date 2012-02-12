class Admin::CheckoutsController < AdminController
  
  def index
    @checkouts = Checkout.order("created_at DESC")
  end
  
  def show
    @checkout = Checkout.find params[:id]
  end
  
end
