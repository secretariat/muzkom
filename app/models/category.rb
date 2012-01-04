class Category < ActiveRecord::Base
  has_many :categories
  belongs_to :category
  
  scope :visible_categories, where(:visibility=> true, :category_id=>0)
end
