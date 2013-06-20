# -*- encoding : utf-8 -*-
class Placement < ActiveRecord::Base
  has_many :locations
  has_many :banners, :through => :locations
end
