class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title, :default=>"", :null=>false
      t.string :meta_d, :default=>"", :null=>false
      t.string :meta_k, :default=>"", :null=>false
      t.datetime :date,  :null=>false
      t.string :description, :default=>"", :null=>false
      t.string :image, :default=>"", :null=>false
      t.text :text, :default=>"", :null=>false
      t.boolean :visibility, :null=>false, :default=>false
      t.timestamps
    end
  end
end
