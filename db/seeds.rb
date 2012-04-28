# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
basic = Role.new(:type => 'basic')
basic.save
admin = Role.new(:type => 'admin')
admin.save

matt = User.find_by_email('matt@dreambop.com')
matt << admin
matt.save

matt = User.find_by_email('info@dreambop.com')
matt << admin
matt.save
