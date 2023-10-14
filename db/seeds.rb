# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

=begin
5.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email

  User.create(
    email: email,
    name: name,
    password: "password",
    password_confirmation: "password"
    )
end
=end

Category.create!([
  { title: '衣類' }, { title: '書籍' }, { title: 'コスメ' }, { title: '文房具' }, { title: 'ゲーム' }, { title: '家電' }
])
