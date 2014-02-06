class CreateBrandGroups < ActiveRecord::Migration
  def change
    create_table :brand_groups do |t|
    	t.string :name
      t.string :input, :default=>"", :limit=>3, :null=>false
      t.string :output, :default=>"", :limit=>3, :null=>false
      t.float :coef, :precision=>10, :scale=>4, :default=>0

      t.timestamps
    end
  end
end