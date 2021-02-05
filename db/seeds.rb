# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = 'foobar'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false
                )

end

User.create!(name: 'admin',
             email: 'admin@example.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)



20.times do |n|
    title = Faker::Lorem.characters(number: 5)
    content = Faker::Lorem.sentence(word_count: 3)
    dead_line = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    user_id = rand(1..10)
    Task.create!(title: title,
                 content: content,
                 status: "未着手",
                 priority: "高",
                 dead_line: dead_line,
                 user_id: user_id)
end

Label.create!(
    name: '仕事'
)
Label.create!(
    name: 'プライベート'
)
Label.create!(
    name: '運動'
)

20.times do |n|
  Labelling.create!(task_id: rand(1..10), label_id: rand(1..3))
end