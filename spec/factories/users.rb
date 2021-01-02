FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test_user@co.jp" }
    password { "foobar" }
  end
  factory :admin_user do
    name {'admin_user'}
    email {'admin_user@co.jp'}
    password {'foobar'}
  end
end
