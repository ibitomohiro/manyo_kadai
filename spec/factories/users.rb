FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test_user@co.jp" }
    password { "foobar" }
    admin { false }
  end
  factory :admin_user, class: User do
    name {'admin_user'}
    email {'admin_user@co.jp'}
    password {'foobar'}
    admin { true }
  end
end
