require 'spec_helper'

describe PostsController do
  let!(:post_one) {FactoryGirl.create(:post, activated_at: DateTime.now)}
  let!(:post_two) {FactoryGirl.create(:post, active: false)}
  let!(:post_three) {FactoryGirl.create(:post, activated_at: DateTime.now - 1.hour)}

  context "GET #index" do
    it "should render the index template" do
      get :index
      response.should render_template :index
    end

    it "should assign all active posts sorted by activated_at" do
      get :index
      assigns(:posts).pluck(:id).should eq([post_three.id, post_one.id])
    end
  end

  context "GET #show" do
    it "should render the show template" do
      get :show, id: post_one.id
      response.should render_template :show
    end
  end

end