# This will guess the User class
FactoryGirl.define do
  factory :exercise do
    duration     10
    workout_details  "pushups"
    activity_date Date.today.strftime('%m/%d/%Y')
    user

    trait :invalid_exercise do
      exercise 0
      workout_details "up"
      activity_date (Date.today - 2.days).strftime('%m/%d/%Y')
      user
    end
  end
end