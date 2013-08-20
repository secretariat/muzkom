class AddColorPresenceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :color_presence, :boolean, :default=>false
  end
end
