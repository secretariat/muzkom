#encoding: utf-8
class FillStatuses < ActiveRecord::Migration
  def up
    ["INSERT INTO `statuses` (`id`, `name`) VALUES(1, 'нет в наличии');",
    "INSERT INTO `statuses` (`id`, `name`) VALUES(2, 'есть в наличии');",
    "INSERT INTO `statuses` (`id`, `name`) VALUES(3, 'ожидается');",
    "INSERT INTO `statuses` (`id`, `name`) VALUES(5, 'наличие уточняйте');",
    "INSERT INTO `statuses` (`id`, `name`) VALUES(4, 'снят с производства')"].each do |line|
      execute line
    end
  end

  def down
  end
end
