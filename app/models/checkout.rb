class Checkout < ActiveRecord::Base

  validates_presence_of :firstname, :lastname, :fathername, :phone, :email, :country, :city, :address
  validates :email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  has_many :purchases
  
  def add_purchases_from_cart(cart)
    cart.items.each do |item|
      purchases << Purchase.from_cart_item(item)
    end
  end
  
end
