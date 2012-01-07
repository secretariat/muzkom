class CategoriesController < ShopController
  def show
    @subcategory = Subcategory.find params[:id]
    @products = Product.find_all_by_subcategory_id params[:id]
  end
end
