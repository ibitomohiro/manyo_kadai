class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :dead_line, presence: true
  validates :status, presence:true
  scope :recent, -> { order(created_at: :desc)}
  scope :over, -> { order(dead_line: :asc)}
  scope :search_title, ->  (title) {where('title LIKE ?', "%#{ title }%")}
  scope :search_status, -> (status) {where(status: status)}
end
