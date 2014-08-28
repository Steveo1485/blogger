class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  scope :active, -> {where(active: true).order(activated_at: :asc)}
end