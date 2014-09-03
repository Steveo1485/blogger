require 'spec_helper'

describe User do
  let!(:user) {FactoryGirl.create(:user)}

  it { should validate_presence_of(:email) }
  it { should_not allow_value("test123").for(:email)}
  it { should allow_value("test123@email.com").for(:email)}

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it "should add user role after create" do
    user.has_role?(:user).should eq(true)
  end

  context "#name" do
    it "should return first and last name of user" do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  context "#primary_role" do
    it "should return admin when user has Admin role" do
      user.add_role(:admin)
      expect(user.primary_role).to eq(:admin)
    end

    it "should return user when user doesn't have admin role" do
      expect(user.primary_role).to eq(:user)
    end
  end

end