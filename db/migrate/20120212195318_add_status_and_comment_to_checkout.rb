class AddStatusAndCommentToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :status, :string, :default => "pending", :null => false
    remove_column :checkouts, :comment
    add_column :checkouts, :comment, :text, :default => "", :null => false
  end
end
