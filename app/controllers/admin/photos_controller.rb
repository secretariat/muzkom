# -*- encoding : utf-8 -*-
class Admin::PhotosController < AdminController
  respond_to :html, :js
  before_filter :remember_id, :only => [:destroy]
  after_filter :remove_id_directory, :only => [:destroy]
  
  def create
    @photo = Photo.new(params[:photo])
    @photo.save
  end
  
  def destroy
    @photo = Photo.find params[:id]
    @photo.destroy
  end

protected

   def remember_id
     @id = params[:id]
   end

   def remove_id_directory
     FileUtils.remove_dir("#{Rails.root}/public/uploads/images/photo/#{@id}", :force => true)
   end
  
end
