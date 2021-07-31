require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
  end

  describe 'ユーザ登録に関するテスト' do
    context 'ユーザーが新規登録をした場合' do
      it 'ログイン画面へ遷移する' do
        visit new_user_path
        fill_in 'user[name]', with: 'natou'
        fill_in 'user[email]', with: 'naitou@naitou.com'
        fill_in 'user[password]', with: 'naitounaitou'
        fill_in 'user[password_confirmation]', with: 'naitounaitou'
        click_button 'commit'
        expect(page).to have_content 'Log in'
      end
    end
    context 'ユーザがログインせずにタスク一覧画面へ飛ぼうとした場合' do
      it 'ログイン画面へ遷移する' do
        visit new_session_path
        click_on 'タスク一覧画面へ'
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'セッション機能に関するテスト' do
    context 'ユーザーがログインした場合' do
      it 'ログインできていること' do
        visit new_session_path
        fill_in 'Email', with: 'kudou@kudou.com'
        fill_in 'Password', with: 'kudoukudou'
        click_button 'commit'
        expect(page).to have_content 'ログイン中'
      end
    end
    context 'ユーザーがログインした場合' do
      it '自分のマイページへ飛ぶ' do
        visit new_session_path
        fill_in 'Email', with: 'satou@satou.com'
        fill_in 'Password', with: 'satousatou'
        click_button 'commit'
        expect(page).to have_content 'satou'
        expect(page).to have_content 'satou@satou.com'
      end
    end
    context '一般ユーザーが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移' do

      end
    end
    context 'ログアウトを押した場合' do
      it 'ログアウトできる' do
        visit new_session_path
        fill_in 'Email', with: 'satou@satou.com'
        fill_in 'Password', with: 'satousatou'
        click_button 'commit'
        click_on "Logout"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end



end
