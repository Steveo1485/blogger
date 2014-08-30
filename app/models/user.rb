class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :registerable, :validatable, :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :registerable

end