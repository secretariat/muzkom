class Product < ActiveRecord::Base

  paginates_per 10
  
  mount_uploader :image, ProductImageUploader
  
  belongs_to :subcategory
  belongs_to :brand
  belongs_to :status
  has_many :photos, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :product_comments, :dependent => :destroy
  
  accepts_nested_attributes_for :videos, :allow_destroy => :true, :reject_if => :all_blank
  
  scope :visible, where(:visibility => true)
  scope :withdrawn, where(:status_id=>4).visible
  scope :on_sale, where("status_id != 4").visible
  scope :latest, order('created_at DESC').limit(2).visible
  
  def self.by_subcategory(subcategory)
    where(:subcategory_id => subcategory.id)
  end
  
  def self.similar(product)
    expensive =  where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price > #{product.price}").limit(3).order("price")
    cheaper = where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price < #{product.price}").limit(3).order("price DESC")
    cheaper | expensive
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
