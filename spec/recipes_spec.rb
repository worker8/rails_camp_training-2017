require "rails_helper"

RSpec.describe "Recipe#index", :type => :request do

  it "shows first 5 recipes" do
    arr = create_recipes(20)
    get "/api/recipes?page=1"

    expect(response.status).to eq(200)
    expect(response.body).to eq(arr.first(5).to_json)
  end

  it "shows next 5 recipes" do
    arr = create_recipes(20)
    get "/api/recipes?page=2"

    expect(response.status).to eq(200)
    expect(response.body).to eq(arr[5..9].to_json)
  end

  it "shows empty array, when no recipe" do
    get "/api/recipes?page=1"

    expect(response.status).to eq(200)
    expect(response.body).to eq([].to_json)
  end

  it "shows empty array, when page is empty" do
    arr = create_recipes(20)
    get "/api/recipes?page=9999"

    expect(response.status).to eq(200)
    expect(response.body).to eq([].to_json)
  end

  def create_recipes(number)
    recipeArr = []
    (1..number).each do |x|
      recipeArr << create(:recipe, title: "recipe#{x}")
    end
    recipeArr
  end

end