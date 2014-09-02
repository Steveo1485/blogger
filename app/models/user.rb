class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :registerable, :validatable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :registerable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :email, presence: true, email: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  after_create :add_user_role

  def name
    "#{first_name} #{last_name}"
  end

  def primary_role
    has_role?(:admin) ? :admin : :user
  end

  private

  def add_user_role
    self.add_role(:user).errors
  end
end