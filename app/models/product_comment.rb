class ProductComment < ActiveRecord::Base
  belongs_to :product
  scope :latest, order("created_at DESC").limit(10)
  validates_presence_of :name, :text, :product_id
end
