class Admin::CurrenciesController < AdminController
  
  def index
  end
  
  def create
    data = calculate(params[:currency])
    @currency = Currency.new(data)
    @currency.save
    redirect_to edit_admin_brand_url params[:brand_id]
  end
  
  def update
    data = calculate(params[:currency])
    @currency = Currency.find params[:id]
    @currency.update_attributes(data)
    @currency.save
    redirect_to redirect_url
  end
  
private

  def calculate(data)
    data[:uah_to_usd] = 1/data[:usd_to_uah].to_f
    data[:uah_to_eur] = 1/data[:eur_to_uah].to_f
    data[:usd_to_eur] = data[:usd_to_uah].to_f/data[:eur_to_uah].to_f
    data[:eur_to_usd] = data[:eur_to_uah].to_f/data[:usd_to_uah].to_f
    data
  end
  
  def redirect_url
    unless params[:brand_id].nil?
      edit_admin_brand_url params[:brand_id]
    else
      admin_root_url
    end
  end
end
