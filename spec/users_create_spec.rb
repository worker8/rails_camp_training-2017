require "rails_helper"

RSpec.describe "User#create", :type => :request do

  it "should return 400, when username is missing" do
    post "/api/users", :params => {
      :user => user_params_without(:username)
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when email is missing" do
    post "/api/users", :params => {
      :user => user_params_without(:email)
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when password is missing" do
    post "/api/users", :params => {
      :user => user_params_without(:password)
    }
    expect(response.status).to eq(400)
  end

  it "should return 200, and create a new user & credential" do
    post "/api/users", :params => {
      :user => user_params
    }

    expect(response.status).to eq(200)
    expect(response.body).to eq(Credential.first.access_token)
    expect(User.first).to eq(Credential.first.user)
  end

  private

  def user_params
    {
      :username => "mr. cook",
      :email => "email@cookpad.com",
      :password => "my_password"
    }
  end

  def user_params_without(to_be_removed)
    user_params.tap do |obj|
      obj.delete(to_be_removed)
    end
  end

end