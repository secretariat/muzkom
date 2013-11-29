class CreditsController < ShopController

	def index
    @credits = Credit.visible.order('created_at DESC').page(params[:page])
  end

  def show
    @credit = Credit.find params[:id]
  end

end
