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

  context "GET #edit" do
    it "should render the edit template" do
      get :edit, id: user.id
      response.should render_template :edit
    end
  end

  context "PUT #update" do
    it "should update the user with valid attributes" do
      put :update, id: user.id, user: { first_name: "Updated" }
      expect(user.reload.first_name).to eq("Updated")
      response.should redirect_to admin_users_path
    end

    it "should not update user with invalid attributes" do
      put :update, id: user.id, user: { first_name: " " }
      expect(user.reload.first_name).to eq(user.first_name)
      response.should render_template :edit
    end
  end

end