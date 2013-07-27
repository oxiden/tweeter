# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seeds = YAML.load_file(Pathname(Rails.root) + "config/seeds.yml")
[1].each do |shop_id|
  shop_seed = seeds["shop#{shop_id}"]
  shop = Shop.find(shop_id)
  Menu.where(:shop_id => shop_id).delete_all
  menus = shop_seed["menu"]
  menus.each do |date, menu|
    shop.menu.build(:release => date, :title => menu, :memo => "").save!
  end
  puts "shop##{shop_id} done."
end
