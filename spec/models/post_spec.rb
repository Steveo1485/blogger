require 'spec_helper'

describe Post do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }

  context "#set_activated_at after_save" do
    it "should set activated_at after save if active is true" do
      post = FactoryGirl.build(:post, active: true)
      post.save
      expect(post.activated_at).to_not be_nil
    end

    it "should remove existing activated_at after save if active is false" do
      post = FactoryGirl.create(:post, active: true)
      post.active = false
      post.save
      expect(post.activated_at).to be_nil
    end

    it "should not set activated_at if active is false" do
      post = FactoryGirl.build(:post, active: false)
      post.save
      expect(post.activated_at).to be_nil
    end
  end

end