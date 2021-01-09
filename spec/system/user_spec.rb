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
        click_on 'プロフィール'
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
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end
  describe "管理者のテスト" do
    before  do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
      visit new_session_path
      fill_in 'session_email', with: 'admin_user@co.jp'
      fill_in 'session_password', with: 'foobar'
      click_button 'Log in'
    end
    context '管理ユーザーが管理画面にアクセスしたとき' do
      it '管理画面にアクセスができる' do
        visit admin_users_path
        click_on '管理者用ユーザー一覧'
        expect(page).to have_content '管理画面のユーザー　一覧画面だよ！'
      end
    end
    context '一般ユーザーが管理画面にアクセスしたとき' do
      it '管理画面にアクセスができない' do
        click_on 'ログアウト'
        fill_in 'session_email', with: 'test_user@co.jp'
        fill_in 'session_password', with: 'foobar'
        expect(page).not_to have_content '管理画面のユーザー　一覧画面だよ！'
      end
    end
    context '管理ユーザーが新規ユーザーの登録をしたとき' do
      it '新規ユーザーの登録ができる' do
        visit new_admin_user_path
        fill_in 'user_name', with: 'sample_user'
        fill_in 'user_email', with: 'sample_user@co.jp'
        fill_in 'user_password', with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
        click_on 'ユーザーを登録する'
        expect(page).to have_content 'sample_user@co.jp'
        # binding.pry
      end
    end
    context '管理ユーザーが詳細画面にアクセスしたとき' do
      it '詳細画面にアクセスできる' do
        visit admin_user_path(@admin_user.id)
      end
    end
    context '管理ユーザーがユーザーの編集をしたとき' do
      it 'ユーザーの編集ができる' do
        visit edit_admin_user_path(@user.id)
        fill_in 'user_name', with: 'edit_user'
        fill_in 'user_email', with: 'edit_user@co.jp'
        fill_in 'user_password', with: 'foobar'
        fill_in 'user_password_confirmation', with: 'foobar'
        click_on 'ユーザーを登録する'
        expect(page).to have_content 'edit_user@co.jp'
      end
    end
    context '管理ユーザーがユーザーの削除をしたとき' do
      it 'ユーザーの削除ができる' do
        visit admin_users_path
        click_on 'ユーザーを削除する', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'test_user'
      end
    end
  end
end