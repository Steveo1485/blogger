require 'spec_helper'

describe 'Managing Users' do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:user_two) {FactoryGirl.create(:user)}

  before :each do
    sign_in_admin(user)
    click_link "Users"
  end

  context "Index" do
    it "should display User info on index" do
      current_path.should eq(admin_users_path)

      within "#user-#{user.id}" do
        page.should have_content user.id
        page.should have_content user.name
        page.should have_content user.primary_role
        page.should have_content user.email
      end
      within "#user-#{user_two.id}" do
        page.should have_content user_two.id
        page.should have_content user_two.name
        page.should have_content user_two.primary_role
        page.should have_content user_two.email
      end
    end
  end

  context "Editing" do
    before :each do
      within "#user-#{user.id}" do
        click_link "Manage User"
        click_link "Edit User"
      end
    end

    it "should allow editing of user with valid attributes" do
      current_path.should eq(edit_admin_user_path(user.id))
      fill_in "user_first_name", with: "Updated First"
      click_button "Update User"
      current_path.should eq(admin_users_path)
      within "#user-#{user.id}" do
        page.should have_content "Updated First"
      end
    end

    it "should display errors when using invalid attributes" do
      fill_in "user_first_name", with: " "
      click_button "Update User"
      page.should have_content "Oops! Something went wrong..."
      page.should have_content "First name can't be blank."
    end
  end

  context "Destroy" do
    before :each do
      within "#user-#{user_two.id}" do
        click_link "Manage User"
        click_link "Delete User"
      end
    end

    it "should delete user" do
      current_path.should eq(admin_users_path)
      page.should have_content "User deleted successfully!"
      page.should_not have_content user_two.name
    end
  end
end