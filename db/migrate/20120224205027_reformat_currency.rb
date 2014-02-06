# -*- encoding : utf-8 -*-
class ReformatCurrency < ActiveRecord::Migration
  def up
    rename_table :currencies, :currencies_old

    create_table :currencies do |t|
      t.integer :brand_id, :null=>false
      t.string :input, :default=>"", :limit=>3, :null=>false
      t.string :output, :default=>"", :limit=>3, :null=>false
      t.float :coef, :precision=>10, :scale=>4, :default=>0
      t.timestamps
    end

    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'usd', 'uah', 8.100)"
    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'eur', 'uah', 11.000)"
    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'usd', 'eur', 0.7364)"
    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'eur', 'usd', 1.3580)"
    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'uah', 'usd', 0.1235)"
    execute "INSERT INTO `currencies` (`brand_id`, `input`, `output`, `coef`) VALUES (0, 'uah', 'eur', 0.0909)"

  end

  def down
    drop_table :currencies
    rename_table :currencies_old, :currencies
  end
end
