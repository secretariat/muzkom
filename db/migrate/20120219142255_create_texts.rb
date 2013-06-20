# -*- encoding : utf-8 -*-
class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :name, :default=>"", :null=>false
      t.text :text, :default => "", :null=>false
      t.timestamps
    end
  end
end
