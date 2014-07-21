require 'spec_helper'

describe PostsController do
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post)}

  context "GET #index" do
    it "should render the index template" do
      get :index
      response.should render_template :index
    end

    it "should assign all posts" do
      get :index
      assigns(:posts).pluck(:id).should eq([post_one.id, post_two.id])
    end
  end

end