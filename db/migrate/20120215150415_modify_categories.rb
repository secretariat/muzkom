class ModifyCategories < ActiveRecord::Migration
  def up
    add_column :categories, :title, :string, :default => "", :null => false
    add_column :categories, :meta_d, :string, :default => "", :null => false
    add_column :categories, :meta_k, :string, :default => "", :null => false
    add_column :categories, :text, :text, :default => "", :null => false
  end

  def down
  end
end
