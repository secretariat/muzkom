class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :subcategory_id
      t.integer :brand_id
      t.string :name, :default=>"", :null=>false
      t.string :title, :default=>"", :null=>false
      t.string :meta_d, :default=>"", :null=>false
      t.string :meta_k, :default=>"", :null=>false
      t.string :image, :default=>"", :null=>false
      t.string :short_description, :default=>"", :null=>false
      t.text :description, :default=>"", :null=>false
      t.decimal :price, :precision=>10, :scale=>2, :default=>0
      t.string :currency, :null=>false, :default=>"UAH", :limit=>3
      t.boolean :visibility, :default=>false
      t.string :status_id, :null=>false, :default=>""
      t.timestamps
    end
  end
end
