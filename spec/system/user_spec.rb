require 'rails_helper'
RSpec.feature 'ユーザー登録のテスト', type: :system do
  describe '新規登録のテスト' do
    context 'ユーザーが新規登録を行ったとき' do
      it 'ユーザーのデータ登録ができる' do
        visit new_user_path
        fill_in 'user_name', with: 'test_user'
        fill_in 'user_email', with: 'test_user@co.jp'
        fill_in 'user_password', with: 'foobar'
        fill_in 'user_password_confirmation', with:'foobar'
        click_on 'Create my account'
        expect(page).to have_content 'test_user@co.jp'
      end
    end
    context 'ログインせずにタスク一覧にとんだ場合' do
      it 'ログイン画面に推移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
      visit new_session_path
      fill_in 'session_email', with: 'test_user@co.jp'
      fill_in 'session_password', with: 'foobar'
      click_button 'Log in'
    end
    context 'ログインをしたとき' do
      it 'ログインができること' do
        expect(page).to have_content 'test_user@co.jp'
      end
    end
    context '自分の詳細ページのテスト' do
      it '詳細ページに飛べること' do
        click_on 'Profile'
        expect(page).to have_content 'test_user@co.jp'
      end
    end
    context '他人の詳細画面に移動しようとしたとき' do
      it 'タスク一覧画面に遷移させられる' do
        visit user_path(@admin_user.id)
        expect(page).to have_content 'Taskを検索する'
      end
    end
    context 'ログアウトをしたとき' do
      it 'ログアウトができる' do
        click_on 'Log out'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
end