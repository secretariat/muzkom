class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :banner_id, :null=>false
      t.integer :placement_id, :null=>false
      t.integer :position, :null=>false
      t.timestamps
    end
  end
end
