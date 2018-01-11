# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Book.delete_all
Publisher.delete_all
Category.delete_all
BookAuthor.delete_all
Order.delete_all
OrderItem.delete_all

# User table
role = 0
15.times do |n|
  if n == 0
    role = 1
    email = "admin@gmail.com"
  else
    role = 0
    email = "user#{n+1}@gmail.com"
  end
  User.create(
    name: "Nguyen Van A0#{n+1}",
    password: "123456",
    password_confirmation: "123456",
    email: email,
    phone: "0123456789",
    address: "HN",
    role: role
  )
end

# Publisher table
15.times do |n|
  Publisher.create name: "Nha xuat ban 0#{n+1}"
end

# Category table
15.times do |n|
  Category.create name: "The loai 0#{n+1}"
end

# Author table
15.times do |n|
  Author.create name: "Tac gia 0#{n+1}"
end

# Book table
i = 0
15.times do |n|
  if n % 3 == 0
    i = 0
  end
  i = i + 1

  Book.create(
    name: "Ruby on rails 0#{n+1}",
    picture: "image0#{i}.jpg",
    price: 23000+n*1000,
    status: true,
    category_id: n+1,
    publisher_id: n+1
  )
end

# Book_author table
15.times do |n|
  BookAuthor.create(
    author_id: n+1,
    book_id: n+1
  )
end
