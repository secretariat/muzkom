#encoding: utf-8
class FillCategories < ActiveRecord::Migration
  
  def up
    ["INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(24, 'DJ оборудование', 1, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(26, 'Студия', 2, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(40, 'Синтезаторы/Рабочие станции', 3, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(41, 'Барабаны/Ударные', 4, false);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(25, 'Гитарное оборудование', 5, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(49, 'Гитарные аксессуары ', 6, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(48, 'Микрофоны', 10, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(46, 'Коммутация/Кабеля', 14, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(47, 'Сумки/Рэки/Стойки', 15, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(27, 'Свет', 16, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(44, 'Звук', 17, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(45, 'Спецэффекты/Лазера', 18, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(50, 'Наушники HI-FI', 19, true);",
    "INSERT INTO `categories` (`id`, `name`, `priority`, `visibility`) VALUES(39, 'Мультимедиа', 20, false);"].each do |line|
      execute line
    end
  end
  
  def down
  end
  
end