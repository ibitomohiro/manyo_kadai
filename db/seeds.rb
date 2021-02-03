# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
name = Faker::Games::Pokemon.name
email = Faker::Internet.email
password = "password"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
             admin: true
             )
end

10.times do |n|
  User.all.each do |user|
    title = Faker::Job.title
    content = Faker::Job.field
    user.tasks.create!(title: title, content: content)
  end
end

10.times do |n|
  name = Faker::Color.color_name
  Label.create!(name: :name)
end