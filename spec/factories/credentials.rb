FactoryGirl.define do
  factory :credential do
    access_token "MyAccessToken"
    user
  end
end
