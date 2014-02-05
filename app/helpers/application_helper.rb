# -*- encoding : utf-8 -*-
module ApplicationHelper

  CURRENCIES = {:usd=>"USD", :uah=>"грн", :eur=>"EUR"}

  def meta_data(obj)
    title obj.title
    meta_d obj.meta_d
    meta_k obj.meta_k
  end

  def meta_d(meta_d)
    @meta_description = meta_d
  end

  def meta_k(meta_k)
    @meta_keywords = meta_k
  end

  def title(title)
    @meta_title = title
  end

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
    human_price product.price_converted(session[:currency])
  end

  def product_old_price(product)
    human_price product.price_converted(session[:currency], false)
  end

  def real_product_price(price)
    number_with_precision(price, :precision => 2, :separator => '.')
  end

  def show_subcategories(category)
    return "hidden" if @current_category.nil?
    return "hidden" unless @current_category.id == category.id
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

  def revert_price( products )
    products.each do |p|
      p.sale_price = 0.0 if p.sale_price == p.price
      if p.promo?
        p.sale_price = human_price p.price_converted_reverse( session[:currency])
        p.price = human_price p.price_converted_reverse( session[:currency], false)
      else
        p.price = human_price p.price_converted_reverse( session[:currency] )
      end
    end
    return products
  end

  def sort_price_withfix( products )
    # puts "start"
    products.each do |p|
      if p.promo?
        p.sale_price = human_price p.price_converted( session[:currency] )
        p.price = human_price p.price_converted( session[:currency], false )
      else
        p.price = human_price p.price_converted( session[:currency] )
        p.sale_price = p.price
      end
    end
    return products
  end

end
