class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, :default=>"", :null=>false
      t.string :title, :default=>"", :null=>false
      t.string :meta_d, :default=>"", :null=>false
      t.string :meta_k, :default=>"", :null=>false
      t.string :uri, :default=>"", :null=>false
      t.text :text, :default=>"", :null=>false
      t.boolean :visibility, :null=>false, :default=>false
      t.timestamps
    end
  end
end
