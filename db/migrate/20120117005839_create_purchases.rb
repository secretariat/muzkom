# -*- encoding : utf-8 -*-
class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :checkout_id, :null=>false
      t.integer :product_id, :null=>false
      t.integer :quantity, :null=>false, :default=>1
      t.decimal :price, :null=>false, :precision=>10, :scale=>2, :default=>0.01
      t.timestamps
    end
  end
end
