class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products
  has_many :brands, :through => :products
  scope :visible, where(:visibility=> true)
end
