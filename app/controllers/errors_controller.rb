class ErrorsController < ShopController
	before_filter :latest_products

  def error_404
  end

  def error_500
  end
end
