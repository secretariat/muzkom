# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate

	private
  def authenticate
    @current_user = current_user
    redirect_to login_url unless current_user
  end
end
