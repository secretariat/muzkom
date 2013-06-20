# -*- encoding : utf-8 -*-
class Status < ActiveRecord::Base
  has_many :products
end
