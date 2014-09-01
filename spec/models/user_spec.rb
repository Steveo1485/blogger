require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should_not allow_value("test123").for(:email)}
  it { should allow_value("test123@email.com").for(:email)}

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it "should add user role after create" do
    user = FactoryGirl.create(:user)
    user.has_role?(:user).should eq(true)
  end

end