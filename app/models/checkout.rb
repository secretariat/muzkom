# -*- encoding : utf-8 -*-
class Checkout < ActiveRecord::Base
  
  STATUSES = {"Ожидает"=>"pending", "Выполняется"=>"started", "Выполнен"=>"finished"}

  validates_presence_of :firstname, :lastname, :fathername, :phone, :email, :country, :city, :address
  validates :email, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  has_many :purchases
  
  scope :pending, where(:status=>"pending")
  
  def add_purchases_from_cart(cart)
    cart.items.each do |item|
      purchases << Purchase.from_cart_item(item)
    end
  end
  
  def fullname
    "#{firstname} #{lastname} #{fathername}"
  end
  
end
