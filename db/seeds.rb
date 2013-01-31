# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Initial Device data.
['Other', 'iOS', 'Android'].each do |v|
  device = Device.new
  device.name = v
  device.key = v.downcase
  device.save
end