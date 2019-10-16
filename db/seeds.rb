# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Language.destroy_all
%w(English Dutch German French).each do |language|
  Language.create(name: language)
end

Subject.destroy_all
%w(English Mathematics Physics Chemistry Biology).each do |subject|
  Subject.create(name: subject)
end