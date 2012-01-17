class Product < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :brand
  belongs_to :status
  
  scope :visible, where(:visibility=>false)
  
  scope :withdrawn, where(:status_id=>4).visible
  scope :latest, order('created_at DESC').limit(2).visible
  
  
  def self.similar(product)
    where(:brand_id=>product.brand.id, :subcategory_id=>product.subcategory.id).limit(6)
  end
  
  def converted_price(curr)
    @rate = brand.conversion
    if currency != curr
      price*@rate.send("#{currency}_to_#{curr}") 
    else
      price
    end
  end
  
end
