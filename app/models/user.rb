class User < ApplicationRecord
  before_destroy :ensure_last_admin
  before_validation { email.downcase! }
  validates :email, uniqueness: true
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence:true, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, dependent: :destroy

  private
  def ensure_last_admin
    if self.admin == true
      if User.all.where(admin: true).count == 1
      throw (:abort)
      end
    end
  end
end
