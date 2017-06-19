FactoryGirl.define do

  factory :user do
    email
    password_digest
    username
  end

  sequence(:email) { |n| "#{n}@cookpad.com" }
  sequence(:username) { |n| "#{n}_chef" }
  sequence(:password_digest) { |n| "#{n}password_digest" }
end
