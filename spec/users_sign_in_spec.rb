require "rails_helper"

RSpec.describe "Credential#sign_in", :type => :request do

  it "should return 400, when email is missing" do
    sign_in_params_without_email = sign_in_params.tap do |obj|
      obj.delete(:email)
    end

    post "/api/credentials", :params => {
      user: sign_in_params_without_email
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when password is missing" do
    sign_in_params_without_password = sign_in_params.tap do |obj|
      obj.delete(:password)
    end

    post "/api/credentials", :params => {
      user: sign_in_params_without_password
    }
    expect(response.status).to eq(400)
  end

  it "should return 401, when email is wrong" do
    sign_in_params_with_wrong_email = sign_in_params.tap do |obj|
      obj[:email] = "WRONG!"
    end

    post "/api/credentials", :params => {
      user: sign_in_params_with_wrong_email
    }
    expect(response.status).to eq(401)
  end

  it "should return 401, when password is wrong" do
    sign_in_params_with_wrong_password = sign_in_params.tap do |obj|
      obj[:password] = "WRONG!"
    end

    post "/api/credentials", :params => {
      user: sign_in_params_with_wrong_password
    }
    expect(response.status).to eq(401)
  end

  private

  def sign_in_params
    {
      :username => "mr. cook",
      :email => "email@cookpad.com",
      :password => "my_password"
    }
  end
end