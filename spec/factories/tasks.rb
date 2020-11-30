# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'test_title_1' }
    content { 'test_content_1' }
    dead_line { DateTime.now }
    status { '完了' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'test_title_2' }
    content { 'test_content_2' }
    dead_line {DateTime.now.tomorrow }
    status { '着手中' }
  end
  factory :third_task, class: Task do
    title { 'test_title_3' }
    content { 'test_content_3' }
    dead_line { DateTime.now + 3.days }
    status { '未着手' }
  end
end