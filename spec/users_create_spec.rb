require "rails_helper"

RSpec.describe "User#create", :type => :request do

  it "should return 400, when username is missing" do
    user_params_with_username_missing = user_params.tap do |obj|
      obj.delete(:username)
    end

    post "/api/users", :params => {
      :user => user_params_with_username_missing
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when email is missing" do
    user_params_with_email_missing = user_params.tap do |obj|
      obj.delete(:email)
    end

    post "/api/users", :params => {
      :user => user_params_with_email_missing
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when password is missing" do
    user_params_with_password_missing = user_params.tap do |obj|
      obj.delete(:password)
    end

    post "/api/users", :params => {
      :user => user_params_with_password_missing
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
end