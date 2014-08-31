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
end