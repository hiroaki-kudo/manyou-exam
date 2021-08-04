require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
  end


  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it 'タスクと一緒に複数のラベルを登録できる' do
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
        check "sample1"
        check "sample2"
        click_button 'commit'
        expect(page).to have_content '勉強'
        expect(page).to have_content 'プログラミング'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it 'タスクに紐づいているラベルも一覧も表示される' do
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
         check "sample1"
         check "sample2"
         click_button 'commit'
         task = Task.find_by(name: '勉強')
         click_link '詳細', href: task_path(task.id)
         expect(page).to have_content 'sample1'
         expect(page).to have_content 'sample2'
       end
     end
  end

  describe '編集機能作成' do
     context '任意のタスクを編集した場合' do
       it '任意のタスク（ラベルも含んで）編集できている' do
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
         check "sample1"
         click_button 'commit'
         task = Task.find_by(name: '勉強')
         click_link '編集', href: edit_task_path(task.id)
         check "sample2"
         click_button 'commit'
         binding.pry
         click_link '詳細', href: task_path(task.id)
         binding.pry
         expect(page).to have_content 'sample1'
         expect(page).to have_content 'sample2'
       end
     end
  end

  describe '検索機能' do
    context 'ラベルを１つ選択して検索をした場合' do
      it "そのラベルを含むタスクで絞り込まれる" do
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
        check "sample1"
        click_button 'commit'
        click_on 'タスクの新規作成'
        fill_in 'task[name]', with: '遊び'
        fill_in 'task[detail]', with: 'ゲーム'
        fill_in 'task[end_date]', with: '002025-04-01'
        select '完了'
        select '高'
        check "sample2"
        click_button 'commit'
        select 'sample1'
        click_on '検索'
        expect(page).to have_content '勉強'
        expect(page).not_to have_content '遊び'
      end
    end
  end

end
