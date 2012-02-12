class DefaultCurrencies < ActiveRecord::Migration
  def up
    execute "INSERT INTO `currencies` (`usd_to_uah`, `eur_to_uah`, `uah_to_usd`, `eur_to_usd`, `uah_to_eur`, `usd_to_eur`) VALUES (8.100, 11.000, 0.1235, 1.3580, 0.0909, 0.7364)"
  end
  
  def down
    execute "TRUNCATE `currencies`"
  end
end
