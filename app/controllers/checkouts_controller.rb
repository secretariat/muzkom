class CheckoutsController < ShopController
  
  def new
    @checkout = Checkout.new
  end
  
  def create
    @checkout = Checkout.new(params[:order])
    @checkout.add_purchases_from_cart(@cart)
    if @checkout.save
      session[:cart] = nil
      flash[:submitted_order_id] = @checkout.id
      redirect_to checkout_finish_url
    else
      flash[:notice] = t("flash.form_error")
      render :action => :new
    end
  end
end
