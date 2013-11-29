# -*- encoding : utf-8 -*-
class PromotionsController < ShopController

  def index
    @promotions = Promotion.visible.order('created_at DESC').page(params[:page])
  end

  def show
    @promotion = Promotion.find params[:id]
  end

end
