class PublicationComment < ActiveRecord::Base
  belongs_to :publication
  scope :latest, order("created_at DESC").limit(10)
  validates_presence_of :name, :text, :publication_id
end
