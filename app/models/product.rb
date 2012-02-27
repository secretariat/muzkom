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
  
  validates_presence_of :name, :price, :currency, :subcategory_id, :brand_id
  
  accepts_nested_attributes_for :videos, :allow_destroy => :true, :reject_if => :all_blank
  
  scope :visible, where(:visibility => true)
  scope :for_index, where(:show_index => true).order("RAND()").limit(12)
  scope :withdrawn, where(:status_id => 4).visible
  scope :on_sale, where("status_id != 4").visible
  scope :latest, order('created_at DESC').limit(2).visible.on_sale
  scope :order_by_price, select("id, name, price, currency, image, short_description, brand_id, sale_price, CASE currency WHEN  'uah' THEN price ELSE (SELECT coef FROM currencies WHERE (brand_id = brand_id AND input = currency AND output =  'uah') OR (brand_id =0 AND input = currency AND output ='uah') ORDER BY id LIMIT 1) * price END AS total").order('total')
  
  def self.by_subcategory(subcategory)
    visible.on_sale.where(:subcategory_id => subcategory.id)
  end
  
  def self.similar(product)
    expensive =  visible.on_sale.where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price > #{product.price}").limit(3).order("price")
    cheaper = visible.on_sale.where("status_id != 4 AND subcategory_id=#{product.subcategory.id} AND price < #{product.price}").limit(3).order("price DESC")
    cheaper | expensive
  end
  
  def price_converted(global_currency, opt = true)
    output_price = (opt == true) ? price_or_sale_price.to_f : price.to_f
    if currency != global_currency
      coef = brand.currency_rate(currency, global_currency)
      output_price*coef
    else
      output_price
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
