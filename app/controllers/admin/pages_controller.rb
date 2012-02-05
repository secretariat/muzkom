class Admin::PagesController < AdminController
  
  def index
    @pages = Page.all
  end
  
end
