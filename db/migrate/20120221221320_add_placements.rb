# -*- encoding : utf-8 -*-
#encoding: utf-8
class AddPlacements < ActiveRecord::Migration
  def up
    ["INSERT INTO `placements` (`name`) VALUES ('Главная (слева)')",
    "INSERT INTO `placements` (`name`) VALUES ('Главная (справа)')",
    "INSERT INTO `placements` (`name`) VALUES ('Страница категории (слева)')",
    "INSERT INTO `placements` (`name`) VALUES ('Страница категории (справа)')",
    "INSERT INTO `placements` (`name`) VALUES ('Страница товара (слева)')",
    "INSERT INTO `placements` (`name`) VALUES ('Страница товара (справа)')",
    "INSERT INTO `placements` (`name`) VALUES ('Корзина (слева)')",
    "INSERT INTO `placements` (`name`) VALUES ('Корзина (справа)')",
    "INSERT INTO `placements` (`name`) VALUES ('Другие страницы (слева)')",
    "INSERT INTO `placements` (`name`) VALUES ('Другие страницы (справа)')"].each do |line|
      execute line
    end
  end

  def down
  end
end
