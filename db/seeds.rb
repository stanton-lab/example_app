# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Currency.delete_all
Currency.create!([
                   {
                     id:      1,
                     name: 'RUB',
                     default: 0.37,
                     is_active: true
                   },
                   {
                     id:      2,
                     name: 'EUR',
                     default: 29,
                     is_active: true
                   },
                   {
                     id:      3,
                     name: 'USD',
                     default: 25,
                     is_active: true
                   }
                 ])