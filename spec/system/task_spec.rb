require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end


  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      visit new_task_path
      fill_in 'task[name]', with: '勉強'
      fill_in 'task[detail]', with: 'プログラミング'
      fill_in 'task[end_date]', with: '002025-07-01'
      select '未着手'
      click_button 'commit'
      expect(page).to have_content '勉強'
      expect(page).to have_content 'プログラミング'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '新しいタスクの終了期限が最長だった時は一番上に表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        sleep 2.0
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, name: 'task')
         second_task = FactoryBot.create(:second_task)
         visit task_path(task.id)
         expect(page).to have_content 'task'
         expect(page).not_to have_content 'Factoryで作ったデフォルトのタイトル２'
       end
     end
  end

  describe '検索機能' do
    # before do
    #   必要に応じて、テストデータの内容を変更して構わない
    #   FactoryBot.create(:task, title: "task")
    #   FactoryBot.create(:second_task, title: "sample")
    # end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search', with: 'タイトル１'
        # 検索ボタンを押す
        click_on '検索'
        expect(page).to have_content 'タイトル１'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        select '着手中'
        click_on '検索'
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit tasks_path
        fill_in 'search', with: 'タイトル３'
        select '完了'
        click_on '検索'
        expect(page).to have_content 'タイトル３'
        expect(page).to have_content '完了'
      end
    end
  end

end
