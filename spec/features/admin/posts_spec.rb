require 'spec_helper'

describe "Admin Posts" do
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post)}

  before :each do
    visit admin_posts_path
  end

  context "Index" do
    it "should show a listing of all post titles" do
      page.should have_content post_one.title
      page.should have_content post_two.title
    end

    it "should display link to add new post" do
      page.should have_link "Create Post"
    end
  end
end