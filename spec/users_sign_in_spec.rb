require "rails_helper"

RSpec.describe "Credential#sign_in", :type => :request do
  before(:each) do
    Monban.test_mode!
    @credential = create(:credential)
    @user = @credential.user
  end

  it "should return 400, when email is missing" do
    sign_in_params_without_email = sign_in_params_without :email

    post "/api/credentials", :params => {
      user: sign_in_params_without_email
    }
    expect(response.status).to eq(400)
  end

  it "should return 400, when password is missing" do
    sign_in_params_without_password = sign_in_params_without :password

    post "/api/credentials", :params => {
      user: sign_in_params_without_password
    }
    expect(response.status).to eq(400)
  end

  it "should return 401, when email is wrong" do
    sign_in_params_with_wrong_email = sign_in_params_with_wrong :email

    post "/api/credentials", :params => {
      user: sign_in_params_with_wrong_email
    }
    expect(response.status).to eq(401)
  end

  it "should return 401, when password is wrong" do
    sign_in_params_with_wrong_password = sign_in_params_with_wrong :password

    post "/api/credentials", :params => {
      user: sign_in_params_with_wrong_password
    }
    expect(response.status).to eq(401)
  end

  it "should return 200, when email/pass is correct" do

    post "/api/credentials", :params => {
      user: {
        :email => @user.email,
        :password => @user.password_digest
      }
    }

    expect(response.status).to eq(200)
  end

  private

  def sign_in_params
    return {
      :email => @credential,
      :password => @user.password_digest
    }
  end

  def sign_in_params_without(to_be_removed)
    sign_in_params.tap do |obj|
      obj.delete(to_be_removed)
    end
  end

  def sign_in_params_with_wrong(to_be_changed)
    sign_in_params.tap do |obj|
      obj[:to_be_changed] = "WRONG!"
    end
  end
end