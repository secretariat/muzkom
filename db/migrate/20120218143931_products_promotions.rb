class ProductsPromotions < ActiveRecord::Migration
  def up
    create_table :products_promotions, :id=>false do |t|
      t.integer :product_id, :null=>false
      t.integer :promotion_id, :null=>false
    end  
  end

  def down
    drop_table :products_promotions
  end
end
