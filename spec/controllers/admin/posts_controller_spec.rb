require 'spec_helper'

describe Admin::PostsController do
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post)}
  let!(:post_build) {FactoryGirl.build(:post)}

  context "GET #index" do
    it "should render the admin/posts/index template" do
      get :index
      response.should render_template :index
    end

    it "should assign all posts" do
      get :index
      assigns(:posts).pluck(:id).should eq([post_one.id, post_two.id])
    end
  end

  context "GET #new" do
    it "should render the admin/posts/new template" do
      get :new
      response.should render_template :new
    end
  end

  context "POST #create" do
    it "should create a post with valid params" do
      expect{ post :create, post: post_build.attributes }.to change{Post.count}.by(1)
    end

    it "should redict to admin_post_path for successfully created post" do
      post :create, post: post_build.attributes
      response.should redirect_to admin_post_path(Post.last)
    end

    it "should not create a post with invalid params" do
      expect{ post :create, post: {title: "Title"} }.to_not change{Post.count}
    end

    it "should render the new template if create unsuccessful" do
      post :create, post: {title: "Title"}
      response.should render_template :new
    end
  end

  context "GET #show" do
    it "should render the admin/posts/show template" do
      get :show, id: post_one.id
      response.should render_template :show
    end

    it "should assign the correct post" do
      get :show, id: post_one.id
      assigns(:post).id.should eq(post_one.id)
    end
  end

  context "GET #edit" do
    it "should render the admin/posts/edit template" do
      get :edit, id: post_one.id
      response.should render_template :edit
    end

    it "should assign the correct post" do
      get :edit, id: post_one.id
      assigns(:post).id.should eq(post_one.id)
    end
  end

  context "PUT #update" do
    it "should update a post with valid params" do
      put :update, id: post_one.id, post: { title: "Updated Title" }
      expect(post_one.reload.title).to eq("Updated Title")
    end

    it "should redict to admin_post_path for successfully updated post" do
      put :update, id: post_one.id, post: { title: "Updated Title" }
      response.should redirect_to admin_post_path(post_one.id)
    end

    it "should not update a post with invalid params" do
      put :update, id: post_one.id, post: { title: " " }
      expect(post_one.reload.title).to_not eq(" ")
      expect(post_one.reload.title).to eq(post_one.title)
    end

    it "should render the edit template if update unsuccessful" do
      put :update, id: post_one.id, post: { title: " " }
      response.should render_template :edit
    end
  end
end