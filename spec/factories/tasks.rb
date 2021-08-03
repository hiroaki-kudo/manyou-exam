# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル１' }
    detail { 'Factoryで作ったデフォルトのコンテント１' }
    end_date { '2021-07-01' }
    status { '未着手' }
    rank  { '低' }
    association :user

    trait :with_a_task_and_title_labels do
    after(:build) do |task|
     # label = create(:label)
     task.task_labels << FactoryBot.build(:task_labels, :with_labels)
   end
   end

  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    detail { 'Factoryで作ったデフォルトのコンテント２' }
    end_date { '2021-07-05' }
    status { '着手中' }
    rank  { '中' }
    association :user ,factory: :second_user
  end

  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル３' }
    detail { 'Factoryで作ったデフォルトのコンテント３' }
    end_date { '2021-07-03' }
    status { '完了' }
    rank  { '高' }
    association :user ,factory: :third_user
  end
end
