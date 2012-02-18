class Category < ActiveRecord::Base
  has_many :subcategories, :dependent => :destroy
  scope :visible, where(:visibility=> true).order("categories.priority")
end
