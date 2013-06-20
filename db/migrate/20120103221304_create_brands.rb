# -*- encoding : utf-8 -*-
class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, :default=>"", :null=>false
      t.boolean :visibility, :null=>false, :default=>false
      t.timestamps
    end
  end
end
