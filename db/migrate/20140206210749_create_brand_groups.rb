class CreateBrandGroups < ActiveRecord::Migration
  def change
    create_table :brand_groups do |t|
    	t.string :name
      t.float :usd_to_uah, :precision=> 3, :default=>0
      t.float :eur_to_uah, :precision=> 3, :default=>0
      # t.float :coef, :precision=>10, :scale=>4, :default=>0

      t.timestamps
    end
  end
end
