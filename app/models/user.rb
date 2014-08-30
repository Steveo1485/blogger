class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :registerable, :validatable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :registerable

  validates :email, presence: true, email: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
end