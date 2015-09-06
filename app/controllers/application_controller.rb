# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  protect_from_forgery

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = Session.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, :with => lambda { |exception| render_error 404, exception }
  end

  private

  def render_error(status, exception)
    respond_to do |format|
      format.html { render :template => "errors/error_#{status}", :layout => 'layouts/application', :status => status }
      format.all { render :nothing => true, :status => status }
    end
  end

end
