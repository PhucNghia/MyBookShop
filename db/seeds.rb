# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: "Vu Van Dong",
  password: "admin",
  password_confirmation: "admin",
  email: "admin@gmail.com",
  phone: "01632132609",
  address: "HD",
  role: 1
)
20.times do |n|
  User.create(
    name: "nguyen van a",
    password: "123",
    password_confirmation: "123",
    email: "a#{n+1}@gmail.com",
    phone: "31234567894",
    address: "acdemdao",
    role: 0
  )
end
