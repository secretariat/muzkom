# -*- encoding : utf-8 -*-
module ProductHelper
  
  def new_product_link
    unless params[:subcategory_id].nil?
      new_admin_subcategory_product_path
    else
      return params[:brand_id].nil? ? new_admin_product_path : new_admin_brand_product_path
    end
  end
  
  def edit_product_link(product)
    unless params[:subcategory_id].nil? 
      edit_admin_subcategory_product_path(params[:subcategory_id], product)
    else
      return params[:brand_id].nil? ? edit_admin_product_path(product) : edit_admin_brand_product_path(params[:brand_id], product)
    end
  end
  
  def delete_product_link(product)
    unless params[:subcategory_id].nil? 
      admin_subcategory_product_path(params[:subcategory_id], product)
    else
      return params[:brand_id].nil? ? admin_product_path(product) : admin_brand_product_path(params[:brand_id], product)
    end
  end
  
  def product_visibility_link(product)
    unless params[:subcategory_id].nil? 
      visibility_admin_subcategory_product_path(params[:subcategory_id], product)
    else
      return params[:brand_id].nil? ? visibility_admin_product_path(product) : visibility_admin_brand_product_path(params[:brand_id], product)
    end
  end
  
  def product_cancel_link
    unless params[:subcategory_id].nil? 
      admin_subcategory_products_path(params[:subcategory_id])
    else
      return params[:brand_id].nil? ? admin_products_path : admin_brand_products_path(params[:brand_id])
    end
  end
  
  def product_show_index_link(product)
    unless params[:subcategory_id].nil? 
      show_index_admin_subcategory_product_path(params[:subcategory_id], product)
    else
      return params[:brand_id].nil? ? show_index_admin_product_path(product) : show_index_admin_brand_product_path(params[:brand_id], product)
    end
  end
  
  def show_index_button(value)
    value == true ? image_tag('admin/show_index.png') : image_tag('admin/star_disabled.png')
  end
end
