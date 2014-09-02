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

end