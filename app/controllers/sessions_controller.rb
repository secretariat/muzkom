# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  layout "signin"
 
  def new
    #redirect_to admin_root_url if current_user
    @user_session = Session.new
  end

  def create
    @user_session = Session.new params[:session]
    if @user_session.save
      flash[:notice] = t('authlogic.login')
      redirect_to admin_root_url
    else
      message = ""
      @user_session.errors.messages.each{|key, val| message += val[0]}
      flash.now[:error] = message
      render :action=>:new
    end
  end

  def destroy
    @user_session = Session.find
    @user_session.destroy
    flash[:notice] = t('authlogic.logout')
    redirect_to login_url
  end
  
end
