class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :default=>"", :null=>false
      t.integer :priority, :null=>false
      t.boolean :visibility, :null=>false, :default=>false
      t.timestamps
    end
  end
end
