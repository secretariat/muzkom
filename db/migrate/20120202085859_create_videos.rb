class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :product_id, :null=>false
      t.string :code, :default=>"", :null=>false
      t.timestamps
    end
  end
end
