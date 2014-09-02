class Admin::IndexController < ApplicationController
  layout 'admin/admin'

  before_action :check_authorization

  private

  def check_authorization
    redirect_to root_path, alert: "Sorry, you don't have access to this section." unless current_user.try(:has_role?, :admin)
  end
end