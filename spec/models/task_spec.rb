require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '勉強', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '勉強', detail: '失敗テスト', end_date: '002025-07-01', status: '未着手' )
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
   # 必要に応じて、テストデータの内容を変更して構わない
   let!(:task) { FactoryBot.create(:task, name: 'task') }
   let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
   context 'scopeメソッドでタイトルのあいまい検索をした場合' do
     it "検索キーワードを含むタスクが絞り込まれる" do
       # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
       expect(Task.search_name('task')).to include(task)
       expect(Task.search_name('task')).not_to include(second_task)
       expect(Task.search_name('task').count).to eq 1
     end
   end
   context 'scopeメソッドでステータス検索をした場合' do
     let!(:task) { FactoryBot.create(:task, status: '未着手') }
     let!(:second_task) { FactoryBot.create(:second_task, status: "完了") }
     it "ステータスに完全一致するタスクが絞り込まれる" do
       # ここに内容を記載する
       expect(Task.search_status('未着手')).to include(task)
       expect(Task.search_status('未着手')).not_to include(second_task)
       expect(Task.search_status('未着手').count).to eq 1
     end
   end
   context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
     let!(:task) { FactoryBot.create(:task, name: 'task', status: '未着手') }
     let!(:second_task) { FactoryBot.create(:second_task, name: 'sample', status: "完了") }
     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
       # ここに内容を記載する
       expect(Task.search_name_status('task','未着手')).to include(task)
       expect(Task.search_name_status('task','未着手')).not_to include(second_task)
       expect(Task.search_name_status('task','未着手').count).to eq 1
     end
   end
 end

end
