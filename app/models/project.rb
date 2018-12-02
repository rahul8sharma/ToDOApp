class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :comments, through: :tasks

  validates :name, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true
end
