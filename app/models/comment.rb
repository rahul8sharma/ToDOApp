class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  validates :body, presence: true, length: { maximum: 100 }
  validates :task_id, :user_id, presence: true
end
