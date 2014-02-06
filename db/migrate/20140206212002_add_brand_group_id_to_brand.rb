class AddBrandGroupIdToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :brands_group_id, :integer
  end
end
