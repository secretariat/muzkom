class Brand < ActiveRecord::Base
  
  mount_uploader :logo, BrandLogoUploader
  
  has_many :currencies
  has_many :products, :dependent => :destroy
  has_many :subcategories, :through => :products
  
  scope :alphabetical, where(:visibility => true).order(:name)
  scope :visible,  where(:visibility => true)
  
  def currency_rate(input, output)
    curr = currencies.where(:input=>input, :output=>output)
    unless curr.blank?
      curr[0].coef.to_f
    else
      curr = Currency.where(:brand_id=>0, :input=>input, :output=>output)
      curr[0].coef.to_f
    end
  end

end
