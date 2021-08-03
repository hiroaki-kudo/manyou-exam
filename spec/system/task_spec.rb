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
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        expect(page).to have_content '勉強'
        expect(page).to have_content 'プログラミング'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '遊び'
        expect(task_list[1]).to have_content '勉強'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル２'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '新しいタスクの終了期限が最長だった時は一番上に表示される' do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        sleep 1.0
        expect(task_list[0]).to have_content '2025-07-01'
        expect(task_list[1]).to have_content '2025-04-01'
        expect(task_list[2]).to have_content '2021-07-05'
      end
    end
    context '一覧画面の優先順位でソートのボタンを押した場合' do
      it 'タスクが優先順位の高い順に並び替えられる' do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        click_on '優先順位でソートする'
        task_list = all('.task_row')
        sleep 1.0
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         visit new_session_path
         fill_in 'Email', with: 'kudou@kudou.com'
         fill_in 'Password', with: 'kudoukudou'
         click_button 'commit'
         click_on 'タスク一覧画面へ'
         click_on 'タスクの新規作成'
         fill_in 'task[name]', with: '勉強'
         fill_in 'task[detail]', with: 'プログラミング'
         fill_in 'task[end_date]', with: '002025-07-01'
         select '未着手'
         select '低'
         click_button 'commit'
         task = Task.find_by(name: '勉強')
         click_link '詳細', href: task_path(task.id)
         expect(page).to have_content '勉強'
         expect(page).not_to have_content 'Factoryで作ったデフォルトのタイトル２'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'search', with: '勉'
        # 検索ボタンを押す
        click_on '検索'
        expect(page).to have_content '勉強'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        # プルダウンを選択する「select」について調べてみること
        select '完了'
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        click_on 'タスク一覧画面へ'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '勉強'
        fill_in 'task[detail]', with: 'プログラミング'
        fill_in 'task[end_date]', with: '002025-07-01'
        select '未着手'
        select '低'
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        click_button 'commit'
        fill_in 'search', with: '勉'
        select '未着手'
        click_on '検索'
        expect(page).to have_content '勉強'
        expect(page).to have_content 'プログラミング'
      end
    end
  end

end
