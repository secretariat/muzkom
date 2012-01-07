class Brand < ActiveRecord::Base
  has_many :products
  
  scope :alphabetical, order(:name)


end
