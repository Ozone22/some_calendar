# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'exampleUser@example.com',
             password: 'exampleUser1',
             password_confirmation: 'exampleUser1',
             fio: 'Example User')

9.times do |i|
  name = Faker::Name.first_name
  fio = "#{ name } #{ Faker::Name.last_name } "
  email = Faker::Internet.email("#{ name }#{ i }")
  User.create(email: email,
              password: "passwordTest#{ i }",
              password_confirmation: "passwordTest#{ i }",
              fio: fio)
end

users = User.all
3.times do
  users.each do |user|
    name = Faker::Lorem.sentence(2)
    start_date = Faker::Date.forward(60)
    repeats_every_n_days = Faker::Number.between(3, 30)
    user.events.create!(name: name, start_date: start_date,
                        repeat_type: 'daily',
                        repeats_every_n_days: repeats_every_n_days)
  end
end
