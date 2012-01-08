class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products
  
  scope :visible, where(:visibility=> true)
end
