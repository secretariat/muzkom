# -*- encoding : utf-8 -*-
class Admin::CreditsController < AdminController
  before_filter :find_credit, :only => [:update, :edit, :destroy, :visibility]

  def index
    @credits = Credit.all
  end

  def new
    @credit = Credit.new
  end

  def create
     @credit = Credit.new(params[:credit])
     if @credit.save
       flash[:success] = t('crud.successful_create')
       redirect_to admin_credits_url
     else
       flash[:error] = t('crud.error')
       render :action => :new
     end
   end

  def edit
  end

  def update
    @credit.update_attributes(params[:credit])
    if @credit.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_credits_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end

  def destroy
    @credit.destroy
    flash[:success] = t('crud.successful_destroy')
    redirect_to admin_credits_url
  end

  def visibility
    @credit.visibility = @credit.visibility==false ? true : false
    if @credit.save
      flash[:success] = t('crud.successful_update')
    else
      flash[:error] = t('crud.error')
    end
    redirect_to admin_credits_url
  end

  def upload
    @filename = params[:file].original_filename.gsub(' ', '_')
    File.open(credit_upload_root.join(@filename), 'wb') do |file|
      file.write(params[:file].read)
    end
  end

private
  def find_credit
    @credit = Credit.find params[:id]
  end

end
