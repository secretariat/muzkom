class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null=>false, :limit=>40, :default=>""
      t.string :username, :null=>false, :limit=>20
      t.string :firstname, :null=>false, :limit=>30, :default=>""
      t.string :lastname, :null=>false, :limit=>30, :default=>""
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
  end
end
