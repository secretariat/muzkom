class Admin::PublicationsController < AdminController
  
  def index
    @publications = Publication.all
  end
  
end