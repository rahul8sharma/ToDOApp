class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
