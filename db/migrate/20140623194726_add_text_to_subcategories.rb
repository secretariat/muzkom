class AddTextToSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :text, :text
  end
end
