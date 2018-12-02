class Task < ApplicationRecord
	belongs_to :project
	has_many :comments, dependent: :destroy

	enum status: [:start, :in_progress, :done]
	enum priority: [:low, :medium, :high]
end
