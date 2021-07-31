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
        binding.pry
        expect(page).to have_content 'Log in'
      end
    end
  end

  # describe 'セッション機能に関するテスト' do
  #   context 'ユーザーがログインした場合' do
  #     it 'ユーザーの詳細画面へ遷移する' do
  #       visit new_session_path
  #       fill_in 'user[email]', with: 'naitou@naitou.com'
  #       fill_in 'user[password]', with: 'naitounaitou'
  #       click_button 'commit'
  #       expect(page).to have_content 'naitou'
  #       expect(page).to have_content 'naitou@naitou.com'
  #     end
  #   end
  #   context 'ユーザがログインせずにタスク一覧画面へ飛ぼうとした場合' do
  #     it 'ログイン画面へ遷移する' do
  #       visit new_session_path
  #       click_on 'タスク一覧画面へ'
  #       binding.pry
  #       expect(page).to have_content 'Log in'
  #     end
  #   end
  # end

end
