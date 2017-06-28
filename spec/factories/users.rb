# This will guess the User class
FactoryGirl.define do
  factory :user do
    email     Faker::Internet.email
    password  Faker::Internet.password

    factory :user_with_exercise do
      after(:create) do |user|
        create_list(:exercise, 3, user: user)
      end
    end
  end
end