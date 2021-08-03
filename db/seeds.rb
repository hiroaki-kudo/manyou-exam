# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  User.create!(name: "kamisama",
               email: "kamisama@kamisama.com",
               password: "kamisamakamisama",
               admin: "true"
               )

  9.times do |i|
  User.create!(name: "佐藤#{i + 1}",
                email: "satou#{i + 1}@satou.com",
                password: "satousatou",
                admin: "false"
                )
  end

  10.times do |i|
  Task.create!(name: "勉強#{i + 1}",
               detail: "プログラミング#{i + 1}",
               end_date: "002025-07-0#{i + 1}",
               status: "完了",
               rank: "低",
               )
  end

  10.times do |i|
    Label.create!(title: "sample#{i + 1}")
