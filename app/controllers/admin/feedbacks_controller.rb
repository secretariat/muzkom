# -*- encoding : utf-8 -*-
class Admin::FeedbacksController < AdminController
  
  def index
    @feedbacks = Feedback.order("created_at DESC")
  end
  
  def destroy
    @feedback = Feedback.find params[:id]
    @feedback.destroy
    redirect_to admin_feedbacks_url
  end
  
end
