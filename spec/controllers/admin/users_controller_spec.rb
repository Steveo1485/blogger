require 'spec_helper'

describe Admin::UsersController do
  let!(:user) {FactoryGirl.create(:user)}

  before :each do
    user.add_role(:admin)
    sign_in user
  end

  context "GET #index" do
    it "should render the index template" do
      get :index
      response.should render_template :index
    end

    it "should assign all users, sorted by created_at desc" do
      user_two = FactoryGirl.create(:user, created_at: 5.seconds.ago)
      get :index
      assigns(:users).pluck(:id).should eq(User.order(created_at: :desc).pluck(:id))
    end
  end

end