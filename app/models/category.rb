class Category < ActiveRecord::Base
  has_many :subcategories
  scope :visible_categories, where(:visibility=> true)
end
