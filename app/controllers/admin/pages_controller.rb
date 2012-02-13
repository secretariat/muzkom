class Admin::PagesController < AdminController
    before_filter :find_page, :only => [:update, :edit, :destroy, :visibility]

    def index
      @pages = Page.all
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(params[:page])
      if @page.save
        flash[:success] = t('crud.successful_create')
        redirect_to admin_pages_url
      else
        flash[:error] = t('crud.error')
        render :action => :new
      end
    end

    def edit
    end

    def update
      @page.update_attributes(params[:page])
      if @page.save
        flash[:success] =  t('crud.successful_update')
        redirect_to admin_pages_url
      else
        flash[:error] = t('crud.error')
        render :edit
      end
    end

    def destroy
      @page.destroy
      flash[:success] = t('crud.successful_destroy')
      redirect_to admin_pages_url
    end

    def visibility
      @page.visibility = @page.visibility==false ? true : false
      if @page.save
        flash[:success] = t('crud.successful_update')
      else
        flash[:error] = t('crud.error')
      end
      redirect_to admin_pages_url
    end
  private

    def find_page
      @page = Page.find params[:id]
    end
  
end
