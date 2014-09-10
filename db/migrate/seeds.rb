# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'thomas.taege@eneraque.com', password: 'correcthorsebatterystaple', password_confirmation: 'correcthorsebatterystaple', role: 'admin', manager_email: 'jeremy.pringle@eneraque.com')
User.create(email: 'jeremy.pringle@eneraque.com', password: 'shootlovelycouplerefer', password_confirmation: 'shootlovelycouplerefer', role: 'admin', manager_email: 'jeremy.pringle@eneraque.com')
User.create(email: 'laura.pringle@eneraque.com', password: 'joyforesthappenproduce', password_confirmation: 'joyforesthappenproduce', role: 'admin', manager_email: 'jeremy.pringle@eneraque.com')
