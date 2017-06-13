FactoryGirl.define do

  factory :recipe do
    title "recipeX"
    steps { [build(:step)] }
    ingredients { [build(:ingredient)] }
    user { build(:user) }
  end

end
