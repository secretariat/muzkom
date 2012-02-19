class Admin::UsersController < AdminController
 
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    @user.update_attributes(params[:user])
    if @user.save
      flash[:success] =  t('crud.successful_update')
      redirect_to admin_products_url
    else
      flash[:error] = t('crud.error')
      render :edit
    end
  end
  
end
