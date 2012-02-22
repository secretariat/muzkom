class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.string :name, :default=>"", :null=>false
      t.timestamps
    end
  end
end
