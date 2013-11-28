class Credit < ActiveRecord::Base

  paginates_per 20

  mount_uploader :image, CreditImageUploader
  # has_and_belongs_to_many :products

  scope :visible, where(:visibility=>true)

  def has_image?
    unless image_url.blank?
      return image_url == "/assets/fallback/default.jpg" ? false : true
    end
  end

end
