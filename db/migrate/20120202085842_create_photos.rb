class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :product_id, :null=>false
      t.string :image, :default=>"", :null=>false
      t.timestamps
    end
  end
end
