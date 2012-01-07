class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :products
  scope :visible_categories, where(:visibility=> true, :category_id=>0)
end
