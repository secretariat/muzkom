# -*- encoding : utf-8 -*-
class Admin::TextsController < AdminController
    before_filter :find_text, :only => [:update, :edit, :destroy, :visibility]

    def index
      @texts = Text.all
    end

    def new
      @text = Text.new
    end

    def create
      @text = Text.new(params[:text])
      if @text.save
        flash[:success] = t('crud.successful_create')
        redirect_to admin_texts_url
      else
        flash[:error] = t('crud.error')
        render :action => :new
      end
    end

    def edit
    end

    def update
      @text.update_attributes(params[:text])
      if @text.save
        flash[:success] =  t('crud.successful_update')
        redirect_to admin_texts_url
      else
        flash[:error] = t('crud.error')
        render :edit
      end
    end

    def destroy
      @text.destroy
      flash[:success] = t('crud.successful_destroy')
      redirect_to admin_texts_url
    end

    def visibility
      @text.visibility = @text.visibility==false ? true : false
      if @text.save
        flash[:success] = t('crud.successful_update')
      else
        flash[:error] = t('crud.error')
      end
      redirect_to admin_texts_url
    end
  private

    def find_text
      @text = Text.find params[:id]
    end
  
end
