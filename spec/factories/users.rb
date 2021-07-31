FactoryBot.define do
  factory :user do
    name { 'kamisama' }
    email { 'kamisama@kamisama.com' }
    password { 'kamisamakamisama' }
    password_confirmation { 'kamisamakamisama' }
    # admin  { Faker::Boolean.boolean #true }
    admin  { 'true' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_user, class: User do
    name { 'kudou' }
    email { 'kudou@kudou.com' }
    password { 'kudoukudou' }
    password_confirmation { 'kudoukudou' }
    admin  { 'false' }
  end

  factory :third_user, class: User do
    name { 'satou' }
    email { 'satou@satou.com' }
    password { 'satousatou' }
    password_confirmation { 'satousatou' }
    admin  { 'false' }
  end
end
