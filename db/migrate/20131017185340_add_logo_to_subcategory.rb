class AddLogoToSubcategory < ActiveRecord::Migration
  def change
    add_column :subcategories, :logo, :string
  end
end
