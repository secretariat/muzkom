class CreditsController < ShopController

	def index
		@page = Page.find_by_uri params[:uri]
    @credits = Credit.visible.order('created_at DESC').page(params[:page])
  end

  def show
    @credit = Credit.find params[:id]
  end

end
