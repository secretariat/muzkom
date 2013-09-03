# -*- encoding : utf-8 -*-
class ProductComment < ActiveRecord::Base
  belongs_to :product
  scope :latest, order("created_at DESC").limit(10)
  validates_presence_of :name, :text, :product_id
  validates :text, length: { maximum: 400, too_long: "%{count} characters is the maximum allowed" }
  validate :stop_spam

  def stop_spam
  	 errors.add( :text, "can't be in the past") if text.scan(/http?:\/\/[\S]+/).size >= 3
  end

end
