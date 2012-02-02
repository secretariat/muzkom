class Product < ActiveRecord::Base

  paginates_per 10
  
  mount_uploader :image, ProductImageUploader
  
  belongs_to :subcategory
  belongs_to :brand
  belongs_to :status
  has_many :photos
  has_many :videos
  has_many :comments
  
  scope :visible, where(:visibility=>false)
  scope :withdrawn, where(:status_id=>4).visible
  scope :on_sale, where("status_id != 4").visible
  scope :latest, order('created_at DESC').limit(2).visible
  
  def self.by_subcategory(subcategory)
    where(:subcategory_id => subcategory.id)
  end
  
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
  
  def withdrawn?
    status_id == "4" ? true : false
  end
  
end
