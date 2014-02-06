class BrandGroup < ActiveRecord::Base
	has_many :brands
  # attr_accessible :coef, :input, :output, :name
end
