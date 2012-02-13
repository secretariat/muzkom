class Promotion < ActiveRecord::Base
  mount_uploader :image, PromotionImageUploader
end
