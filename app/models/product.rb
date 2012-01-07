class Product < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :brand
end
