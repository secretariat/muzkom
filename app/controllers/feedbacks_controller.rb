# -*- encoding : utf-8 -*-
class FeedbacksController < ShopController

  before_filter :latest_products
  before_filter :find_page

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if verify_recaptcha(:model=> @feedback) && @feedback.save
      @text = Text.find 7
    else
      render :new
    end
  end

private
  def find_page
    @page = Page.find_by_uri "contacts"
  end
end
