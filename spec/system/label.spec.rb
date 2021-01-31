# require 'rails_helper'
# RSpec.describe 'タスク管理機能', type: :system do
#
#   before do
#     user = FactoryBot.create(:user)
#     label = FactoryBot.create(:label)
#     visit new_session_path
#     fill_in :session_email, with: 'test_user@co.jp'
#     fill_in :session_password, with: 'foobar'
#     click_button 'Log in'
#     visit tasks_path
#     @task1 = FactoryBot.create(:task, user: user)
#     @task2 = FactoryBot.create(:second_task, user: user)
#     @task3 = FactoryBot.create(:third_task, user: user)
#   end
#   describe '新規作成機能' do
#     context 'ラベルを新規作成した場合' do
#       it '作成したラベルが表示される' do
#         visit new_task_path
#         fill_in 'task[title]', with: 'task'
#         fill_in 'task[content]', with: 'task'
#         click_on 'task_label_ids_1'
#         click_on "登録する"
#         expect(page).to have_content 'MyString'
#       end
#     end
#   end
# end
