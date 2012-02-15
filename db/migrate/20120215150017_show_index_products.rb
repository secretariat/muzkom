class ShowIndexProducts < ActiveRecord::Migration
  def up
    add_column :products, :show_index, :boolean, :default => false
  end

  def down
  end
end
