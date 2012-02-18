class Product < ActiveRecord::Base

  paginates_per 10
  
  mount_uploader :image, ProductImageUploader
  
  belongs_to :subcategory
  belongs_to :brand
  belongs_to :status
  has_many :photos, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :product_comments, :dependent => :destroy
  has_and_belongs_to_many :promotions
  
  accepts_nested_attributes_for :videos, :allow_destroy => :true, :reject_if => :all_blank
  
  scope :visible, where(:visibility => true)
  scope :for_index, where(:show_index => true).order("RAND()").limit(12)
  scope :withdrawn, where(:status_id => 4).visible
  scope :on_sale, where("status_id != 4").visible
  scope :latest, order('created_at DESC').limit(2).visible.on_sale
  
  def self.by_subcategory(subcategory)
    visible.on_sale.where(:subcategory_id => subcategory.id)
  end
  
  def self.similar(product)
    expensive =  visible.on_sale.where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price > #{product.price}").limit(3).order("price")
    cheaper = visible.on_sale.where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price < #{product.price}").limit(3).order("price DESC")
    cheaper | expensive
  end
  
  def price_converted(curr, opt = true)
    @rate = brand.conversion
    pr = (opt == true) ? price_or_sale_price.to_f : price.to_f
    if currency != curr
      pr*@rate.send("#{currency}_to_#{curr}") 
    else
      pr
    end
  end
  
  def price_or_sale_price
    return (sale_price.to_s == "0.0") ? price : sale_price
  end
  
  def withdrawn?
    status_id == "4" ? true : false
  end
  
  def promo?
    sale_price == 0.0 ? false : true
  end
  
end
