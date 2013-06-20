# -*- encoding : utf-8 -*-
#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Category.create(:name=>"DJ оборудование", :title=>"DJ оборудование", :meta_d=>"DJ оборудование", :category_id=>0)
# Category.create(:name=>"DJ Контроллеры", :title=>"DJ Контроллеры", :meta_d=>"DJ Контроллеры", :category_id=>1)
# Category.create(:name=>"CD/DVD проигрыватели", :title=>"CD/DVD проигрыватели", :meta_d=>"CD/DVD проигрыватели", :category_id=>1)
# Category.create(:name=>"Микшерные пульты", :title=>"Микшерные пульты", :meta_d=>"Микшерные пульты", :category_id=>1)
# Category.create(:name=>"Вертушки", :title=>"Вертушки", :meta_d=>"Вертушки", :category_id=>1)
# Category.create(:name=>"Студия", :title=>"Студия", :meta_d=>"Студия", :category_id=>0)

Currency.create(:brand_id=>0, :usd_to_uah=> 8.1000, :eur_to_uah=>11.0000, :uah_to_usd=>0.1235, :eur_to_usd=>1.3580, :uah_to_eur=>0.0909, :usd_to_eur=>0.7364)
User.create(:username=>"admin", :password=>"12345", :password_confirmation=>"12345", :email=>"a@a.com") 
