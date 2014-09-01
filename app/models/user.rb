class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :registerable, :validatable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :registerable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :email, presence: true, email: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  after_create :add_user_role

  private

  def add_user_role
    self.add_role(:user).errors
  end
end