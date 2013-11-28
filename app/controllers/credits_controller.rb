class CreditsController < ShopController

	def index
    @credits = Credit.visible.page(params[:page])
  end

  def show
    @credit = Credit.find params[:id]
  end

end
