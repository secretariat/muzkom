class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.integer :brand_id, :null=>false
      t.float :usd_to_uah, :precision=>10, :scale=>4, :default=>0
      t.float :eur_to_uah, :precision=>10, :scale=>4, :default=>0
      t.float :uah_to_usd, :precision=>10, :scale=>4, :default=>0
      t.float :eur_to_usd, :precision=>10, :scale=>4, :default=>0
      t.float :uah_to_eur, :precision=>10, :scale=>4, :default=>0
      t.float :usd_to_eur, :precision=>10, :scale=>4, :default=>0
      t.timestamps
    end
  end
end
