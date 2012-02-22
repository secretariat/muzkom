class ModifyBanner < ActiveRecord::Migration
  def up
    remove_column :banners, :code
    rename_column :banners, :position, :image
    add_column :banners, :link, :string, :default=>""
  end

  def down
    add_column :banners, :code, :text, :default=>""
    rename_column :banners, :image, :position
    remove_column :banners, :link
  end
end
