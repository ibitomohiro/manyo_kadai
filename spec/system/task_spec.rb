require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    visit tasks_path
    @task1 = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
    @task3 = FactoryBot.create(:third_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'task'
        fill_in 'task[content]', with: 'task'
        select '2020', from: :task_dead_line_1i
        select '12', from: :task_dead_line_2i
        select '31', from: :task_dead_line_3i
        select '未着手', from: :task_status
        click_on "登録する"
        expect(page).to have_content 'task'
      end
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      visit tasks_path
      click_on '投稿時間が新しい順番に並び替える'
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'test_content_3'
    end
    it 'タスクの期限が近い順に並び替え' do
      visit current_path
      click_on '終了期順が近い順番に並び替える'
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'test_content_1'
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        visit tasks_path
        fill_in :task_title, with: 'test_title_1'
        click_on "検索する"
        task_list = all('.task_row')
        expect(page).to have_content 'test_content_1'
        expect(page).not_to have_content 'test_content_2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中', from: :task_status
        click_on "検索する"
        expect(page).to have_content 'test_content_2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in :task_title, with: 'test_title_3'
        select '未着手', from: :task_status
        click_on "検索する"
        expect(page).to have_content 'test_content_3'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end
