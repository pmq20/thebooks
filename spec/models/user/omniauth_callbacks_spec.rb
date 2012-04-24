require "spec_helper"

describe User::OmniauthCallbacks do
  let(:callback) { Class.new.extend(User::OmniauthCallbacks) }
  let(:data) { { "email" => "email@example.com", "nickname" => "_why" } }
  let(:uid) { "42" }
  describe "new_from_provider_data" do
    it "should respond to :new_from_provider_data" do
      callback.should respond_to(:new_from_provider_data)
    end
    it "should create a new user" do
      callback.new_from_provider_data(nil, nil, data).should be_a(User)
    end
    it "should handle provider douban properly" do
      callback.new_from_provider_data("douban", uid, data).email.should == "42@douban.user.com"
    end
    it "should generate some random password" do
      callback.new_from_provider_data(nil, nil, data).password.should_not be_blank
    end
    it "should set user location" do
      data["location"] = "Shanghai"
      callback.new_from_provider_data(nil, nil, data).location.should == "Shanghai"
    end
    it "should set user tagline" do
      description = data["description"] = "A newbie Ruby developer"
      callback.new_from_provider_data(nil, nil, data).tagline.should == description
    end
  end
end
    
