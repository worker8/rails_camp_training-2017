require "rails_helper"

RSpec.describe "User#follow", :type => :request do

  it "should follow another user, when both users exists" do
    credential1 = create(:credential)
    credential2 = create(:credential)

    post "/api/users/#{credential1.user.id}/follow", :params => {
      :access_token => credential2.access_token
    }
    expect(response.status).to eq(200)
    expect(Follow.count).to eq(1)

    relationship = Follow.first
    expect(relationship.follower).to eq(credential2.user)
    expect(relationship.followed_user).to eq(credential1.user)
  end

  it "should return 400 bad request, when one user doesn't exist" do
    credential1 = create(:credential)

    post "/api/users/99999999/follow", :params => {
      :access_token => credential1.access_token
    }
    expect(response.status).to eq(400)
    expect(Follow.count).to eq(0)
  end

  it "should unfollow another user, when both users exists" do
    credential1 = create(:credential)
    credential2 = create(:credential)

    post "/api/users/#{credential1.user.id}/unfollow", :params => {
      :access_token => credential2.access_token
    }
    expect(response.status).to eq(200)
    expect(Follow.count).to eq(0)

  end

end