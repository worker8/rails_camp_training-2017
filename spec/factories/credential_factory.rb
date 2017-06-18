FactoryGirl.define do
  factory :credential do
    access_token
    user { build(:user) }
  end

  sequence(:access_token) { |n| "#{n}accessToken" }
end
