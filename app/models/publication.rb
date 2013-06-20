# -*- encoding : utf-8 -*-
class Publication < ActiveRecord::Base
  
  has_many :publication_comments
  paginates_per 20
  
  mount_uploader :image, PublicationImageUploader
  scope :visible, where(:visibility=>true)
  scope :latest, visible.order("date DESC").limit(3)
  scope :by_date, visible.order("date DESC")
  
  def has_image?
    unless image_url.blank?
      return image_url == "/assets/fallback/publication/default.jpg" ? false : true
    end
  end
  
  def lead
    return description.blank? ? meta_d : description
  end
  
end
