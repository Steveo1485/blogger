class Admin::UsersController < Admin::IndexController

  def index
    @users = User.all
  end

end