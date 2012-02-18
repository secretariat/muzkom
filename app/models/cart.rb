class Cart
  attr_accessor :items
  
  def initialize
    @items = []
  end
  
  def add_product(product, quantity=1)
    current_item = @items.find{|item| item.product == product}
    if current_item
      current_item.increment_quantity(quantity)
    else
      current_item = CartItem.new(product, quantity)
      @items << current_item
    end
    current_item
  end
  
  def delete_product(product)
    current_item = @items.find{|item|item.product == product}
    if current_item  
      if current_item.quantity > 1
        current_item.decrease_quantity
      else
        @items.delete(current_item)
      end
    end
  end
  
  def total(curr)
    @items.sum {|item| item.product.price_converted(curr)*item.quantity}
  end
end
