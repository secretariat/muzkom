# -*- encoding : utf-8 -*-
class Slide < ActiveRecord::Base
  validates_presence_of :image, :link
  
  mount_uploader :image, SlideUploader
  
end
