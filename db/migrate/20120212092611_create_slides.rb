class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :link, :default=>"", :null=>false
      t.string :image, :default=>"", :null=>false
      t.integer :position, :default=>0, :null=>false
      t.timestamps
    end
  end
end
