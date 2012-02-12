class CheckoutsController < ShopController
  
  def new
    redirect_to cart_path if @cart.items.empty?
    @checkout = Checkout.new
  end
  
  def create
    @checkout = Checkout.new(params[:checkout])
    @checkout.add_purchases_from_cart(@cart)
    if @checkout.save
      session[:cart] = nil
      Mailer.client_purchase_notification(@checkout).deliver
      Mailer.admin_purchase_notification(@checkout).deliver
      flash[:submitted_order_id] = @checkout.id
      redirect_to finish_checkout_url
    else
      flash[:notice] = t("flash.form_error")
      render :new
    end
  end
  
  def finish
    
  end
end
