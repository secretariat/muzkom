# -*- encoding : utf-8 -*-
class Admin::CheckoutsController < AdminController

  def index
    @checkouts = Checkout.order("created_at DESC")
  end

  def show
    @checkout = Checkout.find params[:id]
  end

  def update
    @checkout = Checkout.find params[:id]
    @checkout.update_attributes(params[:checkout])
    if @checkout.save
      flash[:notice] = t("crud.successful_update")
      redirect_to admin_checkout_url(@checkout)
    else
      render :show
    end
  end

  def destroy
    @checkout = Checkout.find params[:id]
    @checkout.destroy
    redirect_to admin_checkouts_url
  end


end
