# README

- Ruby version  2.6.5
- Rails version 5.2.4.4
- PostgreSQL    12.3

## Task モデル
| テーブル | データ型 |
----|---- 
|  id   | iteger |
| title | string |
| content | text |
|dead_line | datetime |

## User モデル
| テーブル | データ型 |
----|---- 
| id | integer  |
| name | string |
|e-mail | string |
| password_digest | string |

## Label モデル
| テーブル | データ型 |
----|----
|user_id | integer |
| task_id | integer |

## herokuへのデプロイの方法
デプロイしたいアプリへのディレクトリへ移動する
1. % heroku create　                                (コマンドでherokuへ新しいアプリの作成)
2. % heroku buildpacks:set heroku/ruby             (Rubyのbuildpackの追加)
3. % heroku buildpacks:add --index 1 heroku/nodejs (node.jsのbuildpackの追加)
4. % git push heroku master (herokuへデプロイ)
5. % git run rails db:migrate (マイグレーションの実行)
6. % heroku open (アプリを開く)