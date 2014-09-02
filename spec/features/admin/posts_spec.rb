require 'spec_helper'

describe "Admin Posts" do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:post_one) {FactoryGirl.create(:post)}
  let!(:post_two) {FactoryGirl.create(:post, active: false)}
  let!(:post_build) {FactoryGirl.create(:post)}

  before :each do
    sign_in_admin(user)
  end

  context "Index" do
    it "should show a listing of all post titles" do
      page.should have_content post_one.title
      page.should have_content post_two.title
    end

    it "should display link to add new post" do
      page.should have_link "Create Post"
    end

    it "should display when Post was posted if applicable" do
      within "#post-#{post_one.id}" do
        page.should have_content post_one.activated_at.strftime("%b %e, %Y")
      end
      within "#post-#{post_two.id}" do
        page.should have_content "Not Posted Yet"
      end
    end
  end

  context "Creating post" do
    before :each do
      click_link "Create Post"
    end

    it "should be on the admin_new_post_path" do
      current_path.should eq(new_admin_post_path)
    end

    it "should redirect to post's show page after successful post creation" do
      fill_in "post_title", with: post_build.title
      fill_in "post_content", with: post_build.content
      click_button "Save Post"
      current_path.should eq(admin_post_path(Post.last.id))
      page.should have_content post_build.title
      page.should have_content post_build.content
    end

    it "Cancel button should take back to index" do
      click_link "Cancel"
      current_path.should eq(admin_posts_path)
    end

    context "when post creation wasn't successful" do
      before :each do
        fill_in "post_title", with: post_build.title
        click_button "Save Post"
      end

      it "should display errors" do
        page.should have_content "Oops! Something went wrong..."
        page.should have_content "Content can't be blank."
      end

      it "should remember entered values" do
        find_field("post_title").value.should eq(post_build.title)
      end
    end
  end

  context "Viewing post" do
    before :each do
      within "#post-#{post_one.id}" do
        click_link "View Details"
      end
    end

    it "should be on the admin_post_path" do
      current_path.should eq(admin_post_path(post_one.id))
    end

    it "should display post details" do
      page.should have_content post_one.title
      page.should have_content post_one.content
    end

    it "should display Edit Post link" do
      page.should have_link "Edit Post"
    end

    it "back button should take back to Posts index" do
      click_link "Back"
      current_path.should eq(admin_posts_path)
    end
  end

  context "Editing post" do
    before :each do
      within "#post-#{post_one.id}" do
        click_link "View Details"
      end
      click_link "Edit Post"
    end

    it "should beon the edit_admin_post_path" do
      current_path.should eq(edit_admin_post_path(post_one.id))
    end

    it "should allow user to edit post" do
      fill_in "post_title", with: "Updated Title"
      click_button "Update Post"
      current_path.should eq(admin_post_path(post_one.id))
      page.should have_content "Updated Title"
    end

    it "should display errors if update unsuccessful" do
      fill_in "post_title", with: " "
      click_button "Update Post"
      page.should have_content "Oops! Something went wrong..."
      page.should have_content "Title can't be blank."
    end

    it "Cancel button should take back to post's show view" do
      click_link "Cancel"
      current_path.should eq(admin_post_path(post_one.id))
    end
  end

  context "Deleting a post" do
    before :each do
      within "#post-#{post_one.id}" do
        click_link "View Details"
      end
    end

    it "should display 'Delete Post' link" do
      page.should have_link "Delete Post"
    end

    it "should allow post to be destroyed" do
      click_link "Delete Post"
      current_path.should eq(admin_posts_path)
      page.should_not have_content post_one.title
    end
  end
end