# -*- encoding : utf-8 -*-
class Banner < ActiveRecord::Base
  has_many :locations
  has_many :placements, :through => :locations
  
  mount_uploader :image, BannerUploader
end
