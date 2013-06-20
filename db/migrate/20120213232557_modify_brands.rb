# -*- encoding : utf-8 -*-
class ModifyBrands < ActiveRecord::Migration
  def up
    add_column :brands, :title, :string, :default => "", :null => false
    add_column :brands, :meta_d, :string, :default => "", :null => false
    add_column :brands, :meta_k, :string, :default => "", :null => false
    add_column :brands, :logo, :string, :default => "", :null => false
    add_column :brands, :text, :text, :default => "", :null => false
  end

  def down
  end
end
