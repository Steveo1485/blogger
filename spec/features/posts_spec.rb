require 'spec_helper'

describe "Posts" do
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post, active: false)}

  before :each do
    visit "/"
  end

  it "should display active posts on index path" do
    page.should have_content post_one.title
    page.should have_content post_one.content
    page.should_not have_content post_two.title
    page.should_not have_content post_two.content
  end

  context "viewing post" do
    before :each do
      click_link "Read More"
    end

    it "should display specific post content" do
      current_path.should == post_path(post_one.id)
      page.should have_content post_one.title
      page.should have_content post_one.content
    end
  end
end