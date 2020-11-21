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
