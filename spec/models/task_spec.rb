require 'rails_helper'
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(title: '失敗テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          @user = FactoryBot.create(:user)
          @task = FactoryBot.create(:task, user: @user)
          expect(@task).to be_valid
        end
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    before do
      @user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user: @user)
      @second_task = FactoryBot.create(:second_task, user: @user)
    end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_title('test_title_1')).to include(@task)
        expect(Task.search_title('test_title_1')).not_to include(@second_task)
        expect(Task.search_title('test_title_1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手中')).to include(@second_task)
        expect(Task.search_status('着手中')).not_to include(@task)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('test_title_2').search_status('着手中')).to include(@second_task)
        expect(Task.search_title('test_title_2').search_status('着手中')).not_to include(@task)
        expect(Task.search_title('test_title_2').search_status('着手中').count).to eq 1
      end
    end
  end