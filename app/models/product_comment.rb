# -*- encoding : utf-8 -*-
class ProductComment < ActiveRecord::Base
  belongs_to :product
  scope :latest, order("created_at DESC").limit(10)
  validates_presence_of :name, :text, :product_id
  validates_length_of :text, :maximum => 400
  validate :stop_spam

  def stop_spam
  	 errors.add( :text, "too many links") if text.scan(/http?:\/\/[\S]+/).size >= 3
  end

end
