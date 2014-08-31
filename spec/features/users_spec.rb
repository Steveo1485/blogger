require 'spec_helper'

describe "User" do

  context "sign up" do
    before :each do
      @user = FactoryGirl.build(:user)
      visit new_user_registration_path
    end

    it "should display errors when not all required fields are submitted" do
      click_button "Sign up"
      page.should have_content "Oops! Something went wrong..."
      page.should have_content "First name can't be blank."
      page.should have_content "Last name can't be blank."
      page.should have_content "Username can't be blank."
      page.should have_content "Email can't be blank."
      page.should have_content "Password can't be blank."
      page.should have_content "Password confirmation can't be blank."
    end

    it "should redirect to root path after successful submission" do
      fill_in "user_first_name", with: @user.first_name
      fill_in "user_last_name", with: @user.last_name
      fill_in "user_username", with: @user.username
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password
      click_button "Sign up"
      current_path.should eq(root_path)
    end
  end

  context "sign in" do
    before :each do
      @user = FactoryGirl.create(:user)
      visit new_user_session_path
    end

    it "should display errors when not successful" do
      fill_in "user_email", with: "wrong@email.com"
      fill_in "user_password", with: "invalid"
      click_button "Log In"
      page.should have_content "Invalid email or password."
    end

    it "should redirect to root path when signing in as general user" do
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Log In"
      page.should have_content "Signed in successfully."
      current_path.should eq(root_path)
    end

    xit "should reidrect to Admin Panel when signing in as an admin" do
    end
  end

end