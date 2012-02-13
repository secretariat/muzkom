#encoding: utf-8
module ApplicationHelper
  
  CURRENCIES = {:usd=>"USD", :uah=>"грн", :eur=>"EUR"}
  
  def human_date(date)
    return "–" if date.nil?
    date.strftime('%d.%m.%Y')
  end
  
  def human_date_time(date)
    return "–" if date.nil?
    date.strftime('%d.%m.%Y %H:%M')
  end
  
  def human_price(price)
    number_with_precision(price, :precision => 2, :separator => '.')+" #{CURRENCIES[:"#{session[:currency]}"]}"
  end
  
  def product_price(product)
    human_price product.converted_price(session[:currency])
  end
  
  def real_product_price(price)
    number_with_precision(price, :precision => 2, :separator => '.')
  end
  
  def show_subcategories(category)
    return "hidden" if @current_category.nil?
    return "hidden" unless @current_category.category.id == category.id
  end
  
  def product_class(index)
    return (index%2==0) ? " mlx" : " mrx"
  end
  
  def image_for_product(product)
    if product.id < 6665
      image_tag "/uploads/"+product.image, :width=>100
    else
      image_tag "/uploads/images/products/"+product.image
    end
  end
  
end
