class Publication < ActiveRecord::Base
  
  paginates_per 10
  
  scope :latest, where(:visibility=>true).order("date DESC").limit(3)
  scope :by_date, where(:visibility=>true).order(:date)
  
end
