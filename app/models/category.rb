class Category < ActiveRecord::Base
  has_many :subcategories
  scope :visible, where(:visibility=> true)
end
