class AddWishedColorToCheckout < ActiveRecord::Migration
  def change
    add_column :checkouts, :wished_color, :string
  end
end
