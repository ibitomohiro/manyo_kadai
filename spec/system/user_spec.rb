# require 'rails_helper'
#
# RSpec.feature 'ユーザーのテスト', type: :system do
#   describe '新規登録のテスト' do
#     context 'ユーザーの新規登録画面を入力' do
#       it 'ユーザーネームのデータが登録されている' do
#         visit new_user_path
#         fill_in 'user_name', with: 'test_user'
#         fill_in 'user_email', with: 'test_user@co.jp'
#         fill_in 'user_password', with: 'foobar'
#         fill_in 'user_password_confirmation', with:'foobar'
#         click_on 'Create my account'
#         expect(page).to have_content 'test_user@co.jp'
#       end
#     end
#   end
# end