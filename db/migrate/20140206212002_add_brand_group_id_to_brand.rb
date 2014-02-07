class AddBrandGroupIdToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :brand_group_id, :integer
  end
end
