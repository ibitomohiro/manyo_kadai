require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system do
  before do
    @label = FactoryBot.create(:label)
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in :session_email,  with: 'test_user@co.jp'
    fill_in :session_password, with: 'foobar'
    click_button 'Log in'
    visit tasks_path
  end

  describe '新規のラベルを作成機能のテスト' do
    context 'タスクの新規作成時、ラベルも作成も登録したとき' do
      it 'タスク一覧作成画面にラベルも登録される' do
        visit new_task_path
        fill_in 'task[title]', with: 'task'
        fill_in 'task[content]', with: 'task content'
        select '2020', from: :task_dead_line_1i
        select '12', from: :task_dead_line_2i
        select '31', from: :task_dead_line_3i
        select '未着手', from: :task_status
        select '高', from: :task_priority
        check 'task_label_ids_5'
        click_on '登録する'
        expect(page).to have_content "label_1"
      end
    end
  end

  describe 'ラベルの検索機能' do
    context 'ラベル名で検索をした場合' do
      it '検索したラベルが表示される' do
        visit tasks_path
        select 'label_1', from: 'task[label_id]'
        save_and_open_page
        click_button '検索する'
        expect(page).to have_content 'label_1'
      end
    end
  end
  context 'タスク名とラベルで検索したとき' do
    it 'タスク名とラベル名で一致したタスクが表示される' do
      visit tasks_path
      select '完了', from: 'task[status]'
      fill_in 'task[title]', with: 'test_content_1'
      select 'label_1', from: 'task[label_id]'
      click_button '検索する'
      expect(page).to have_content 'label_1'
    end
  end
end