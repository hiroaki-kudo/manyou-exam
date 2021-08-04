
  user = User.create!(name: "kamisama",
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
               end_date: "2025-07-01",
               status: "完了",
               rank: "低",
               user: user
               )
  end

  10.times do |i|
    Label.create!(title: "sample#{i + 1}")
  end
