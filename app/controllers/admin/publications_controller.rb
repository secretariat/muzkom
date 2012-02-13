class Admin::PublicationsController < AdminController
  
    before_filter :find_publication, :only => [:update, :edit, :destroy, :visibility]

    def index
      @publications = Publication.all
    end

    def new
      @publication = Publication.new
    end

    def create
      @publication = Publication.new(params[:publication])
      if @publication.save
        flash[:success] = t('crud.successful_create')
        redirect_to admin_publications_url
      else
        flash[:error] = t('crud.error')
        render :action => :new
      end
    end

    def edit
    end

    def update
      @publication.update_attributes(params[:publication])
      if @publication.save
        flash[:success] =  t('crud.successful_update')
        redirect_to admin_publications_url
      else
        flash[:error] = t('crud.error')
        render :edit
      end
    end

    def destroy
      @publication.destroy
      flash[:success] = t('crud.successful_destroy')
      redirect_to admin_publications_url
    end

    def visibility
      @publication.visibility = @publication.visibility==false ? true : false
      if @publication.save
        flash[:success] = t('crud.successful_update')
      else
        flash[:error] = t('crud.error')
      end
      redirect_to admin_publications_url
    end
  private

    def find_publication
      @publication = Publication.find params[:id]
    end
  
end
