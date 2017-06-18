require "rails_helper"

RSpec.describe "Recipe#create", :type => :request do
  it "should return 400 for missing steps" do
    user = create(:user)
    credential = create(:credential, user: user)

    params_missing_steps = create_recipe_params.tap { |obj|
      obj.delete(:steps_attributes)
    }

    post "/api/recipes", :params => {
      :recipe => params_missing_steps,
      :access_token => credential.access_token
    }
    expect(response.status).to eq(400)

  end

  it "should return 401 when access token is missing" do

    post "/api/recipes", :params => {
      :recipe => create_recipe_params
    }

    expect(response.status).to eq(401)
  end

  it "should return 403 when access token is invalid" do

    post "/api/recipes", :params => {
      :recipe => create_recipe_params,
      :access_token => "wrong_token"
    }

    expect(response.status).to eq(403)
  end


  it "should return 200, and create a recipe with valid user" do
    user = create(:user)
    credential = create(:credential, user: user)

    post "/api/recipes", :params => {
      :recipe => create_recipe_params,
      :access_token => credential.access_token
    }

    expect(response.status).to eq(200)
    expect(response.body).to eq(user.recipes.first.to_json)
  end

  private

  def create_recipe_params
    {:title => "My Recipe",
     :description => "this is a recipe ^3^",
     ingredients_attributes: [
       {name: "ingredient1"}
     ],
     steps_attributes: [
       {name: "step1"}
     ]
    }
  end
end