# -*- encoding : utf-8 -*-
class Purchase < ActiveRecord::Base
  belongs_to :checkout
  belongs_to :product

  def self.from_cart_item(cart_item)
    purchase = self.new
    purchase.product = cart_item.product
    purchase.quantity = cart_item.quantity
    purchase.price = cart_item.price('uah')
    purchase
  end

end
