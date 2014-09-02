class Admin::UsersController < Admin::IndexController

  before_action :fetch_user, only: [:edit, :update]

  def index
    @users = User.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: "User updated successfully!"
    else
      render :edit, notice: "User not updated. Please try again."
    end
  end

  private

  def fetch_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

end