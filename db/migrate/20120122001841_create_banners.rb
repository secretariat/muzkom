class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.text :code, :default=>"", :null=> false
      t.string :position, :default=>"", :null=> false
      t.timestamps
    end
  end
end
