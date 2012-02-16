class ProductComment < ActiveRecord::Base
  belongs_to :product
  scope :latest, order("created_at DESC").limit(10)
end
