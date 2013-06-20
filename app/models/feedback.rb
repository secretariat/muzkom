# -*- encoding : utf-8 -*-
class Feedback < ActiveRecord::Base
  validates_presence_of :name, :phone, :email, :text
end
