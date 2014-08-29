class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  after_save :set_activated_at

  scope :active, -> {where(active: true).order(activated_at: :asc)}

  private

  def set_activated_at
    if self.activated_at.nil? && self.active == true
      self.update_attribute(:activated_at, DateTime.now)
    elsif self.activated_at && self.active == false
      self.update_attribute(:activated_at, nil)
    end
  end
end