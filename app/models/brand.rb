class Brand < ActiveRecord::Base
  
  mount_uploader :logo, BrandLogoUploader
  
  has_one :currency
  has_many :products
  has_many :subcategories, :through => :products
  
  scope :alphabetical, order(:name)
  
  def conversion
    unless currency.nil?
      currency
    else
      Currency.find_by_brand_id(0)
    end
  end

end
