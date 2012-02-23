class FeedbacksController < ShopController
  
  before_filter :latest_products
  before_filter :find_page
  
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(params[:feedback])
    unless @feedback.save
      render :new
    else
      @text = Text.find 7
    end
  end
  
private
  def find_page
    @page = Page.find_by_uri "contacts"
  end
end