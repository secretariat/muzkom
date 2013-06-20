# -*- encoding : utf-8 -*-
class PublicationComment < ActiveRecord::Migration
  def change
    create_table :publication_comments do |t|
      t.integer :publication_id, :null=>false
      t.string :name, :null=>false, :default=>""
      t.text :text, :null=>false, :default=>""
      t.timestamps
    end
  end
end
