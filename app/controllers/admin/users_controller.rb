class Admin::UsersController < Admin::IndexController

  def index
    @users = User.order(created_at: :desc)
  end

end