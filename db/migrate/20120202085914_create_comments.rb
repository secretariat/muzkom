class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :product_id, :null=>false
      t.string :name, :null=>false, :default=>""
      t.text :text, :null=>false, :default=>""
      t.timestamps
    end
  end
end
