# encoding: utf-8
module ProductHelper
  
  def new_product_link
     return params[:subcategory_id].nil? ? new_admin_product_path : new_admin_subcategory_product_path
  end
  
  def edit_product_link(product)
    return params[:subcategory_id].nil? ? edit_admin_product_path(product) : edit_admin_subcategory_product_path(params[:subcategory_id], product)
  end
  
  def delete_product_link(product)
    return params[:subcategory_id].nil? ? admin_product_path(product) : admin_subcategory_product_path(params[:subcategory_id], product)
  end
  
  def product_visibility_link(product)
    return params[:subcategory_id].nil? ? visibility_admin_product_path(product) : visibility_admin_subcategory_product_path(params[:subcategory_id], product)
  end
  
  def product_cancel_link
    return params[:subcategory_id].nil? ? admin_products_path : admin_subcategory_products_path(params[:subcategory_id])
  end
end