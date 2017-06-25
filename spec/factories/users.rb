# This will guess the User class
FactoryGirl.define do
  factory :user do
    email     Faker::Internet.email
    password  Faker::Internet.password
  end
end