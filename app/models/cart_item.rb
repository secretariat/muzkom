# -*- encoding : utf-8 -*-
class CartItem
  attr_reader :product_id, :quantity
  
  def initialize(product, quantity=1)
    @product_id = product.id
    @quantity = quantity.to_i
  end
  
  def increment_quantity(qnty)
    @quantity += qnty.to_i
  end
  
  def update_quantity(qnty)
    @quantity = qnty.to_i
  end
  
  def decrease_quantity
    @quantity -= 1
  end
  
  def title
    @product.title
  end
  
  
  def product
    Product.find @product_id
  end
  
  def price(currency)
    product.price_converted(currency) * @quantity
  end
  
end
