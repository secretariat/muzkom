class Publication < ActiveRecord::Base
  
  paginates_per 20
  
  mount_uploader :image, PublicationImageUploader
  scope :visible, where(:visibility=>true)
  scope :latest, visible.order("date DESC").limit(3)
  scope :by_date, visible.order("date DESC")
  
end
