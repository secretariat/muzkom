class Brand < ActiveRecord::Base
  has_many :products
  has_one :currency
  scope :alphabetical, order(:name)
  
  def conversion
    unless currency.nil?
      currency
    else
      Currency.find_by_brand_id(0)
    end
  end

end
