# -*- encoding : utf-8 -*-
class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.string :firstname, :null=>false, :default=>""
      t.string :lastname, :null=>false, :default=>""
      t.string :fathername, :null=>false, :default=>""
      t.string :discount, :null=>false, :default=>""
      t.string :discount_owner, :null=>false, :default=>""
      t.string :email, :null=>false, :default=>""
      t.string :phone, :null=>false, :default=>""
      t.string :country, :null=>false, :default=>""
      t.string :city, :null=>false, :default=>""
      t.string :address, :null=>false, :default=>""
      t.string :delivery_time, :null=>false, :default=>""
      t.string :comment, :null=>false, :default=>""
      t.timestamps
    end
  end
end
