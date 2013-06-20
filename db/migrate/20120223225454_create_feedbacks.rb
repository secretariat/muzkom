# -*- encoding : utf-8 -*-
class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name, :null => false, :default => ""
      t.string :phone, :null => false, :default => ""
      t.string :email, :null => false, :default => ""
      t.string :city, :null => false, :default => ""
      t.string :subject, :null => false, :default => ""
      t.text :text, :null => false, :default => ""
      t.timestamps
    end
  end
end
