require 'spec_helper'

describe Admin::PostsController do
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post)}
  let!(:post_build) {FactoryGirl.build(:post)}

  context "GET #index" do
    it "should render the manage/index template" do
      get :index
      response.should render_template :index
    end

    it "should assign all posts" do
      get :index
      assigns(:posts).pluck(:id).should eq([post_one.id, post_two.id])
    end
  end

  context "GET #new" do
    it "should render the manage/new template" do
      get :new
      response.should render_template :new
    end
  end

  context "POST #create" do
    it "should create a post with valid params" do
      expect{ post :create, post: post_build.attributes }.to change{Post.count}.by(1)
    end

    it "should not create a post with invalid params" do
      expect{ post :create, post: {title: "Title"} }.to_not change{Post.count}
    end
  end
end