class AddSalePriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sale_price, :decimal, :precision => 10, :scale => 2
  end
end
