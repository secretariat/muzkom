# -*- encoding : utf-8 -*-
class Subcategory < ActiveRecord::Base
  belongs_to :category
	mount_uploader :logo, SubcategoryLogoUploader
  has_many :products, :dependent => :destroy
  has_many :brands, :through => :products
  scope :visible, where(:visibility=> true)
end
