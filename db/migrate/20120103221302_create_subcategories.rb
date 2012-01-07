class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.integer :category_id, :default=>0, :null=>false
      t.string :name, :default=>"", :null=>false
      t.string :title, :default=>"", :null=>false
      t.string :meta_d, :default=>"", :null=>false
      t.string :meta_k, :default=>"", :null=>false
      t.integer :priority, :default=>1
      t.boolean :visibility, :null=>false, :default=>false
      t.timestamps
    end
  end
end
