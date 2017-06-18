require "rails_helper"

RSpec.describe "Recipe#destroy", :type => :request do

  it "should return 200, when recipe exists" do
    recipe, access_token = create_recipe

    delete "/api/recipes/#{recipe.id}", :params => {
      :access_token => access_token
    }

    expect(response.status).to eq(200)
    expect(Recipe.count).to eq(0)
  end

  it "should return 400, when recipe not found" do
    recipe, access_token = create_recipe
    delete "/api/recipes/999999", :params => {
      :access_token => access_token
    }

    expect(response.status).to eq(400)
    expect(Recipe.count).to eq(1)
  end

  it "should return 401, when no access token" do
    recipe, access_token = create_recipe

    delete "/api/recipes/#{recipe.id}", :params => {
    }
    expect(response.status).to eq(401)
    expect(Recipe.count).to eq(1)
  end

end